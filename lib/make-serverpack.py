# This script creates the final pack directory, used by clients.
#
# Usage: python make-serverpack.py [packs.json path] [hostname] [base url] [output path]
#
# Testing: python make-serverpack.py with no parameters will use the pack in testdata, and write to test-output.
#

from io import BytesIO
import os
import sys
import json
import shutil
import zipfile

from dataclasses import dataclass, field
from typing import List, Optional, Union


# These types correspond to the ServerPack.xml file.

@dataclass
class URL:
    link: str
    priority: int

@dataclass
class Module:
    name: str
    id: str
    urls: List[URL]
    mod_path: str
    size: int
    required: bool
    mod_type: str
    md5: str
    default: bool = True
    load_prefix: str = None
    in_root: bool = False

@dataclass
class Loader:
    type: str
    version: str
    load_order: Optional[int] = None

@dataclass
class Import:
    url: str
    child: str

@dataclass
class Server:
    id: str
    name: str
    version: str
    news_url: Optional[str] = None
    icon_url: Optional[str] = None
    revision: Optional[Union[str, int]] = None
    main_class: Optional[str] = None
    server_address: Optional[str] = None
    auto_connect: Optional[bool] = True
    imports: List[Import] = field(default_factory=list)
    loader: Optional[Loader] = None
    modules: List[Module] = field(default_factory=list)

@dataclass
class ServerPack:
    version: str
    servers: List[Server]



def CreateServerPack(packs_json: dict, hostname: str, url_base: str, output_path: str) -> None:
    """Creates the final pack directory, used by clients.
    
    Args:
        packs_json (dict): The packs.json file.
        hostname (str): The hostname of the server.
        url_base (str): The base url of the server.
        output_path (str): The path to write the output to.
    
    Returns:
        The path to the created pack directory, containing these files:
        - index.html; an info page.
        - MCUpdater-Bootstrap.jar; the MCUpdater bootstrap jar, preconfigured for this server.\
        - ServerPack.xml; the MCUpdater ServerPack file.
        - packs: A directory containing the pack for each server, with mods and configs.
    """
    # Create output directory
    assert not os.path.exists(output_path), f'Output path {output_path} already exists'
    os.mkdir(output_path)
    
    # Copy index.html
    shutil.copy('index.html', output_path)

    # Copy and edit MCUpdater-Bootstrap.jar
    CreateMCUpdaterBootstrap('MCUpdater-Bootstrap.jar', url_base, output_path)

    # Create the packs directory
    packs_path = os.path.join(output_path, 'packs')
    CreatePacksDir(packs_json, packs_path)

    # Create ServerPack.xml
    CreateServerPackXML(packs_json, hostname, url_base, output_path)


def CreateServerPackXML(packs_json: dict, hostname: str, url_base: str, output_path: str) -> None:
    """Creates the ServerPack.xml file.

    Args:
        packs_json (dict): The packs.json file.
        hostname (str): The hostname of the server.
        url_base (str): The base url of the server.
        output_path (str): The path to write the output to.
    """
    import hashlib

    def MkConfig(location, config_name, config):
        return Module(
            name=f'Config ({config_name})',
            id=config_name,
            urls=[URL(link=f'{location}/{config_name}.zip', priority=0)],
            mod_path='config',
            size=config['size'],
            required=True,
            mod_type='Extract',
            in_root=True,
            md5=config['md5'],
        )
    
    def MkMod(location, mod):
        mod_name = mod['name']
        return Module(
            name=mod['title'],
            id=mod_name,
            urls=[URL(link=f'{location}/{mod["encoded"]}', priority=0)],
            mod_path=f"mods/{mod['filename']}",
            size=mod['size'],
            required=mod['required'],
            default=mod['default'],
            mod_type='Regular',
            md5=mod['md5'],
        )

    def MkFabricImport(minecraft, fabric, yarnBuild):
        return Import(
                url=f"https://fabricmc.net/download/mcupdater?yarn={minecraft}%2B{yarnBuild}&loader={fabric}",
                child="fabric",
        )

    def MkServer(server_name, server, hostname):
        revision = hashlib.sha256(json.dumps(server).encode('utf-8')).hexdigest()
        fabric = server["fabric"]
        imports = [MkFabricImport(server["minecraft"], fabric["loader"], fabric["yarnBuild"])] if fabric is not None else []
        main_class = "net.fabricmc.loader.launch.knot.KnotClient" if fabric is not None else None
        server_address = f'{hostname.split(":")[0]}:{server["port"]}'

        return Server(
            id=server_name,
            name=server['description'],
            version=server['minecraft'],
            news_url='https://madoka.brage.info/',
            revision=revision,
            server_address=server_address,
            auto_connect=False,
            imports=imports,
            #loader=Loader(type='Forge', version='10.13.4.1614'),
            modules=([MkConfig(f'{url_base}packs/{server_name}/configs', config_name, config) for config_name, config in server['clientConfigs'].items()] 
                     + [MkMod(f'{url_base}packs/{server_name}/mods', mod) for mod in server['clientMods']]),
            main_class=main_class,
        )

    servers = [MkServer(server_name, server, hostname) for server_name, server in packs_json.items()]

    serverpack = ServerPack(
        version='3.3',
        servers=servers,
    )

    from xml.etree.ElementTree import Element, SubElement, tostring, ElementTree

    def create_xml(server_pack: ServerPack) -> str:
        root = Element('ServerPack', version=server_pack.version)
        root.attrib["xmlns"] = "http://www.mcupdater.com"
        root.attrib["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
        root.attrib["xsi:schemaLocation"] = "http://www.mcupdater.com http://files.mcupdater.com/ServerPackv2.xsd"
        
        for server in server_pack.servers:
            server_elem = SubElement(root, 'Server', id=server.id, name=server.name, version=server.version)
            if server.news_url:
                server_elem.set('newsUrl', server.news_url)
            if server.icon_url:
                server_elem.set('iconUrl', server.icon_url)
            if server.revision:
                server_elem.set('revision', str(server.revision))
            if server.main_class:
                server_elem.set('mainClass', server.main_class)
            if server.server_address:
                server_elem.set('serverAddress', server.server_address)
            if server.auto_connect:
                server_elem.set('autoConnect', 'true')
            else:
                server_elem.set('autoConnect', 'false')
            for imp in server.imports:
                SubElement(server_elem, 'Import', url=imp.url).text = imp.child
            if server.loader:
                SubElement(server_elem, 'Loader', type=server.loader.type, version=server.loader.version)
            for module in server.modules:
                type_attrib = {'inRoot': 'true'} if module.in_root else {}
                module_elem = SubElement(server_elem, 'Module', name=module.name, id=module.id)
                for url in module.urls:
                    SubElement(module_elem, 'URL', priority=str(url.priority)).text = url.link
                SubElement(module_elem, 'LoadPrefix').text = module.load_prefix
                SubElement(module_elem, 'ModPath').text = module.mod_path
                SubElement(module_elem, 'Size').text = str(module.size)
                SubElement(module_elem, 'Required', isDefault=str(module.default)).text = str(module.required)
                SubElement(module_elem, 'ModType', attrib=type_attrib).text = module.mod_type
                SubElement(module_elem, 'MD5').text = module.md5
        
        # Pretty print
        from xml.dom import minidom
        return minidom.parseString(tostring(root, encoding='utf-8')).toprettyxml(indent='    ')

    xml = create_xml(serverpack)
    with open(os.path.join(output_path, 'ServerPack.xml'), 'w') as f:
        f.write(xml)


def CreatePacksDir(packs_json: dict[str, dict], packs_path: str) -> None:
    """Creates the packs directory, containing the pack for each server, with mods and configs.
    
    Args:
        packs_json (dict): The packs.json file.
        packs_path (str): The path to write the packs directory to.
    """
    os.mkdir(packs_path)
    for pack_name, pack in packs_json.items():
        pack_path = os.path.join(packs_path, pack_name)
        os.mkdir(pack_path)
        configs_dir = os.path.join(pack_path, 'configs')
        mods_dir = os.path.join(pack_path, 'mods')
        os.mkdir(configs_dir)
        os.mkdir(mods_dir)
        for config_name, config in pack['clientConfigs'].items():
            config_path = os.path.join(configs_dir, config_name) + '.zip'
            os.symlink(f'{config["zipDir"]}/{config_name}.zip', config_path)
        for mod in pack['clientMods']:
            mod_from = f'{pack["clientModsDir"]}/{mod["filename"]}'
            mod_to = os.path.join(mods_dir, mod['filename'])
            os.symlink(mod_from, mod_to)
    

def CreateMCUpdaterBootstrap(base_updater: str, url_base: str, output_path: str):
    files = {}
    with zipfile.ZipFile(base_updater, 'r') as z:
        for info in z.infolist():
            files[info.filename] = z.read(info.filename)

    # Add config.properties
    properties = f'''\
bootstrapURL = https://files.mcupdater.com/Bootstrap.xml
distribution = JavaFX-Release
defaultPack = {url_base}ServerPack.xml
customPath =
passthroughArgs = -defaultMem 6G
    '''
    files['config.properties'] = properties.encode('utf-8')

    with zipfile.ZipFile(f'{output_path}/MCUpdater-Bootstrap.jar', 'x') as z:
        for filename, data in files.items():
            z.writestr(filename, data)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        # Testing mode
        packs_json_path = 'testdata/packs.json'
        hostname = open('testdata/hostname').read().strip()
        url_base = open('testdata/url_base').read().strip()
        output_path = 'test-output'
    else:
        packs_json_path = sys.argv[1]
        hostname = sys.argv[2]
        url_base = sys.argv[3]
        output_path = sys.argv[4]
    
    assert os.path.exists(packs_json_path), f'packs.json path {packs_json_path} does not exist'
    assert hostname, 'hostname must be specified'
    assert url_base, 'url_base must be specified'
    assert output_path, 'output_path must be specified'
    
    packs_json = json.load(open(packs_json_path))
    CreateServerPack(packs_json, hostname, url_base, output_path)
