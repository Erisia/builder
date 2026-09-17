"""Transport and evidence invariants; no live server needed."""
import importlib.util
import io
import json
from pathlib import Path
import struct
import tempfile
import unittest
from unittest.mock import patch

SCRIPT = Path(__file__).resolve().parents[1] / 'tools/skills/minecraft-tick-debug/scripts/evidence.py'
spec = importlib.util.spec_from_file_location('tick_evidence', SCRIPT)
evidence = importlib.util.module_from_spec(spec)
spec.loader.exec_module(evidence)


class FakeSocket:
    def __init__(self, data):
        self.data = data
        self.sent = bytearray()
    def __enter__(self): return self
    def __exit__(self, *args): pass
    def settimeout(self, value): pass
    def sendall(self, data): self.sent.extend(data)
    def recv(self, size):
        size = min(size, 7)  # TCP fragmentation is unrelated to RCON packet boundaries.
        value, self.data = self.data[:size], self.data[size:]
        return value


def encoded(ident, kind, body):
    return struct.pack('<iii', len(body) + 10, ident, kind) + body + b'\0\0'


class EvidenceTests(unittest.TestCase):
    def test_split_response_including_multibyte_utf8(self):
        expected = 'x' * 4095 + '世界' + 'z' * 4100
        raw = expected.encode()
        wire = encoded(1, 2, b'')
        for start in range(0, len(raw), 4096):
            wire += encoded(2, 0, raw[start:start + 4096])
        wire += encoded(3, 0, b'list response must not leak into output')
        sock = FakeSocket(wire)
        with patch.object(evidence, 'properties', return_value={'enable-rcon': 'true', 'rcon.password': 'secret'}), patch.object(evidence.socket, 'create_connection', return_value=sock):
            self.assertEqual(evidence.rcon(Path('/unused'), 'forge tps'), expected)

    def test_auth_failure_does_not_send_command(self):
        sock = FakeSocket(encoded(-1, 2, b''))
        with patch.object(evidence, 'properties', return_value={'enable-rcon': 'true', 'rcon.password': 'secret'}), patch.object(evidence.socket, 'create_connection', return_value=sock):
            with self.assertRaisesRegex(RuntimeError, 'authentication'):
                evidence.rcon(Path('/unused'), 'forge tps')
        self.assertNotIn(b'forge tps', sock.sent)

    def test_disconnect_is_not_successful_partial_response(self):
        with self.assertRaisesRegex(RuntimeError, 'closed'):
            evidence.receive(FakeSocket(struct.pack('<i', 100) + b'incomplete'))

    def test_capture_commands_require_local_export_and_deadline(self):
        evidence.check_command('flare sampler start --timeout 30 --save-to-file --force-java-sampler')
        for cmd in ('stop', 'say hello', 'flare sampler view', 'flare sampler start --timeout 30',
                    'flare sampler start --save-to-file', 'flare sampler start --timeout 0 --save-to-file',
                    'flare sampler start --timeout 999 --save-to-file',
                    'flare sampler start --timeout 30 --save-to-file --alloc'):
            with self.subTest(cmd=cmd), self.assertRaises(ValueError): evidence.check_command(cmd)

    def test_capture_does_not_touch_existing_sampler(self):
        with tempfile.TemporaryDirectory() as td, patch.object(evidence, 'rcon', return_value='Active sampler found') as command:
            with self.assertRaisesRegex(RuntimeError, 'already active'):
                evidence.profile(Path(td), Path(td) / 'capture', 15)
            self.assertEqual(command.call_count, 1)

    def test_interrupted_capture_stops_its_sampler(self):
        with tempfile.TemporaryDirectory() as td, patch.object(evidence, 'rcon', side_effect=[
                'No active sampler found', 'Sampler started!', 'Stopping Sampler...']) as command, patch.object(evidence.time, 'sleep', side_effect=KeyboardInterrupt):
            with self.assertRaises(KeyboardInterrupt):
                evidence.profile(Path(td), Path(td) / 'capture', 15)
            self.assertEqual(command.call_args.args[1], 'flare sampler stop --save-to-file')

    def test_partial_snapshot_retains_errors_and_excludes_credentials(self):
        with tempfile.TemporaryDirectory() as td:
            server = Path(td) / 'server'
            server.mkdir()
            (server / 'server.properties').write_text('rcon.password=secret-value\nmotd=private-value\nview-distance=10\n')
            out = Path(td) / 'bundle'
            with patch.object(evidence, 'java_processes', return_value=[]), patch.object(evidence, 'rcon', side_effect=OSError('offline')), patch('sys.stdout', new=io.StringIO()):
                self.assertEqual(evidence.snapshot(server, out), 2)
            settings = json.loads((out / 'server-settings.json').read_text())
            self.assertEqual(settings, {'view-distance': '10'})
            self.assertTrue(json.loads((out / 'collection.json').read_text())['errors'])
            self.assertEqual(out.stat().st_mode & 0o777, 0o700)
            with self.assertRaises(FileExistsError): evidence.snapshot(server, out)




class InspectionTests(unittest.TestCase):
    def setUp(self):
        spec = importlib.util.spec_from_file_location('compare_inspections', SCRIPT.with_name('compare_inspections.py'))
        self.module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.module)

    def snapshot(self, tick, count=1, age=10, complete=True):
        entity = {'uuid': 'persistent', 'age_ticks': age, 'ticks_existed': 10,
                  'item_count': count, 'dead': False}
        return {'schema': 1, 'session': 'same-run', 'query': 'chunk 0 -2 3', 'complete': complete,
                'captured_epoch_ms': tick * 50, 'server_tick': tick,
                'worlds': [{'dimension': 0, 'details_complete': True, 'entity_offset': 0,
                    'entities': [entity], 'chunks': [{'chunk_x': -2, 'chunk_z': 3,
                    'entities': 1, 'item_entities': 1, 'item_units': count}]}]}

    def test_nonaging_uuid_and_stack_growth_are_preserved(self):
        result = self.module.compare(self.snapshot(10), self.snapshot(30, count=20))
        self.assertEqual(result['chunks'][0]['item_unit_delta'], 19)
        self.assertIn('without age', result['retained_items'][0]['finding'])

    def test_partial_reports_do_not_assert_removal(self):
        old, new = self.snapshot(10), self.snapshot(30, complete=False)
        new['worlds'][0]['entities'] = []
        result = self.module.compare(old, new)
        self.assertIsNone(result['missing_item_uuids'])
        self.assertIsNone(result['chunks'][0]['item_unit_delta'])

    def test_sentinel_is_not_classified_as_tick_failure(self):
        result = self.module.compare(self.snapshot(10, age=-32768), self.snapshot(30, age=-32768))
        self.assertIn('sentinel', result['retained_items'][0]['finding'])

    def test_restart_and_identical_tick_comparisons_rejected(self):
        old, new = self.snapshot(10), self.snapshot(30)
        new['session'] = 'restarted'
        with self.assertRaises(ValueError): self.module.compare(old, new)
        with self.assertRaises(ValueError): self.module.compare(old, old)

    def test_only_bounded_inspections_allowed(self):
        for query in ('status', 'census -1', 'chunk 0 -10 20', 'watch start 30 0 -10 20', 'watch status'):
            evidence.check_inspection(query)
        for query in ('kill @e', 'chunk 0 999999999 0', 'watch start 0', 'watch start 61', 'status\nstop', 'eval anything'):
            with self.subTest(query=query), self.assertRaises(ValueError): evidence.check_inspection(query)


if __name__ == '__main__': unittest.main()
