use anyhow::{Context, Result};
use clap::Parser;
use flate2::read::GzDecoder;
use nbt::de::from_reader;
use rayon::prelude::*;
use regex::Regex;
use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

#[derive(Debug, Clone)]
struct Match {
    file_path: PathBuf,
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
    
    // Print sorted results
    let mut current_file: Option<&PathBuf> = None;
    for match_item in &sorted_matches {
        // Only print file path once
        if current_file != Some(&match_item.file_path) {
            println!("{}", match_item.file_path.display());
            current_file = Some(&match_item.file_path);
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
        if search_nbt_value(&nbt_value, &uuid.to_lowercase()) {
            return Ok(vec![Match {
                file_path: relative_path,
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
            }]);
        }
    }
    
    Ok(vec![])
}

fn search_nbt_value(value: &nbt::Value, uuid: &str) -> bool {
    use nbt::Value;
    
    match value {
        Value::String(s) => s.to_lowercase().contains(uuid),
        Value::Compound(map) => {
            for (key, val) in map {
                if key.to_lowercase().contains(uuid) || search_nbt_value(val, uuid) {
                    return true;
                }
            }
            false
        }
        Value::List(list) => list.iter().any(|v| search_nbt_value(v, uuid)),
        Value::ByteArray(bytes) => {
            let bytes_u8: Vec<u8> = bytes.iter().map(|&b| b as u8).collect();
            let content = std::string::String::from_utf8_lossy(&bytes_u8);
            content.to_lowercase().contains(uuid)
        }
        _ => false,
    }
}
