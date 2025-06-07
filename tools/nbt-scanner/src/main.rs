use anyhow::{Context, Result};
use clap::Parser;
use flate2::read::GzDecoder;
use nbt::de::from_reader;
use rayon::prelude::*;
use regex::Regex;
use std::collections::HashMap;
use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

#[derive(Debug, Clone)]
struct Match {
    file_path: PathBuf,
    size: Option<usize>,
}

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    #[arg(help = "The UUID to search for")]
    uuid: String,

    #[arg(help = "Directory to scan")]
    directory: PathBuf,

}

fn main() -> Result<()> {
    let args = Args::parse();
    
    let uuid_regex = Regex::new(&format!(r"(?i){}", regex::escape(&args.uuid)))
        .context("Failed to create regex")?;
    
    println!("Scanning for UUID: {}", args.uuid);
    println!("Directory: {}", args.directory.display());
    println!();
    
    // Collect all file paths first
    let files: Vec<_> = WalkDir::new(&args.directory)
        .follow_links(true)
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.path().is_file())
        .map(|e| e.path().to_path_buf())
        .collect();
    println!("Found {} files", files.len());
    
    // Process files in parallel and collect matches
    let all_matches: Vec<Match> = files
        .par_iter()
        .filter_map(|path| {
            scan_file(path, &args.uuid, &uuid_regex, &args.directory).ok()
        })
        .flatten()
        .collect();
    
    // Sort matches by file path
    let mut sorted_matches = all_matches;
    sorted_matches.sort_by(|a, b| a.file_path.cmp(&b.file_path));
    
    // Group matches by file and calculate totals
    let mut file_totals: HashMap<&PathBuf, (usize, Option<usize>)> = HashMap::new();
    
    for match_item in &sorted_matches {
        let entry = file_totals.entry(&match_item.file_path).or_insert((0, None));
        entry.0 += 1; // Count of matches
        
        if let Some(size) = match_item.size {
            *entry.1.get_or_insert(0) += size; // Sum NBT sizes
        }
    }
    
    // Print sorted results
    let mut sorted_files: Vec<_> = file_totals.into_iter().collect();
    sorted_files.sort_by(|a, b| a.0.cmp(b.0));
    
    for (file_path, (count, total_size)) in sorted_files {
        if let Some(size) = total_size {
            println!("{} (NBT size: {} bytes, {} matches)", file_path.display(), size, count);
        } else {
            println!("{} ({} matches)", file_path.display(), count);
        }
    }
    
    println!("\nTotal matches found: {}", sorted_matches.len());
    
    Ok(())
}

fn scan_file(path: &Path, uuid: &str, uuid_regex: &Regex, base_dir: &Path) -> Result<Vec<Match>> {
    let mut file = File::open(path)?;
    let mut data = Vec::new();
    file.read_to_end(&mut data)?;
    
    let relative_path = path.strip_prefix(base_dir).unwrap_or(path).to_path_buf();
    
    // First, try to parse as NBT
    if let Ok(nbt_value) = from_reader::<_, nbt::Value>(&mut &data[..]) {
        if let Some(size) = search_nbt_value(&nbt_value, &uuid.to_lowercase()) {
            return Ok(vec![Match {
                file_path: relative_path,
                size: Some(size),
            }]);
        }
        return Ok(vec![]);
    }
    
    // If NBT parsing failed, try to decompress with gzip and search
    if let Ok(decompressed) = decompress_gzip(&data) {
        return search_text(&decompressed, &relative_path, uuid_regex);
    }
    
    // If decompression failed, just search the raw data
    search_text(&data, &relative_path, uuid_regex)
}

fn decompress_gzip(data: &[u8]) -> Result<Vec<u8>> {
    let mut decoder = GzDecoder::new(data);
    let mut decompressed = Vec::new();
    decoder.read_to_end(&mut decompressed)?;
    Ok(decompressed)
}

fn search_text(data: &[u8], file_path: &PathBuf, uuid_regex: &Regex) -> Result<Vec<Match>> {
    let content = String::from_utf8_lossy(data);
    
    for line in content.lines() {
        if uuid_regex.is_match(line) {
            return Ok(vec![Match {
                file_path: file_path.clone(),
                size: None,
            }]);
        }
    }
    
    Ok(vec![])
}

fn estimate_nbt_size(value: &nbt::Value) -> usize {
    use nbt::Value;
    
    match value {
        Value::Byte(_) => 1,
        Value::Short(_) => 2,
        Value::Int(_) => 4,
        Value::Long(_) => 8,
        Value::Float(_) => 4,
        Value::Double(_) => 8,
        Value::String(s) => 2 + s.len(), // 2 bytes for length prefix + string bytes
        Value::ByteArray(bytes) => 4 + bytes.len(), // 4 bytes for length + data
        Value::IntArray(ints) => 4 + (ints.len() * 4), // 4 bytes for length + 4 bytes per int
        Value::LongArray(longs) => 4 + (longs.len() * 8), // 4 bytes for length + 8 bytes per long
        Value::List(list) => {
            // 1 byte for type + 4 bytes for length + sum of all elements
            5 + list.iter().map(|v| estimate_nbt_size(v)).sum::<usize>()
        }
        Value::Compound(map) => {
            // Sum of all entries, each entry has: 1 byte type + 2 bytes name length + name + value
            map.iter().map(|(key, val)| 1 + 2 + key.len() + estimate_nbt_size(val)).sum::<usize>() + 1 // +1 for end tag
        }
    }
}

fn search_nbt_value(value: &nbt::Value, uuid: &str) -> Option<usize> {
    use nbt::Value;
    
    match value {
        Value::String(s) => {
            if s.to_lowercase().contains(uuid) {
                Some(2 + s.len()) // String size: 2 bytes length prefix + string bytes
            } else {
                None
            }
        }
        Value::Compound(map) => {
            // Check if any key contains the UUID
            for (key, _) in map {
                if key.to_lowercase().contains(uuid) {
                    return Some(estimate_nbt_size(value)); // Return size of entire compound
                }
            }
            
            // Check if any value contains the UUID
            for (_, val) in map {
                if let Some(_) = search_nbt_value(val, uuid) {
                    return Some(estimate_nbt_size(value)); // Return size of entire compound
                }
            }
            None
        }
        Value::List(list) => {
            for item in list {
                if let Some(_) = search_nbt_value(item, uuid) {
                    return Some(estimate_nbt_size(value)); // Return size of entire list
                }
            }
            None
        }
        Value::ByteArray(bytes) => {
            let bytes_u8: Vec<u8> = bytes.iter().map(|&b| b as u8).collect();
            let content = std::string::String::from_utf8_lossy(&bytes_u8);
            if content.to_lowercase().contains(uuid) {
                Some(4 + bytes.len()) // ByteArray size: 4 bytes length + data
            } else {
                None
            }
        }
        _ => None,
    }
}
