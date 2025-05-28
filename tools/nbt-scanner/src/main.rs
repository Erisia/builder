use anyhow::{Context, Result};
use clap::Parser;
use flate2::read::GzDecoder;
use nbt::de::from_reader;
use rayon::prelude::*;
use regex::Regex;
use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};
use walkdir::WalkDir;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    #[arg(help = "The UUID to search for")]
    uuid: String,

    #[arg(help = "Directory to scan")]
    directory: PathBuf,

    #[arg(short, long, help = "Show full file paths")]
    verbose: bool,
}

fn main() -> Result<()> {
    let args = Args::parse();
    
    let uuid_regex = Regex::new(&format!(r"(?i){}", regex::escape(&args.uuid)))
        .context("Failed to create regex")?;
    
    println!("Scanning for UUID: {}", args.uuid);
    println!("Directory: {}", args.directory.display());
    println!();
    
    let found_count = AtomicUsize::new(0);
    
    // Collect all file paths first
    let files: Vec<_> = WalkDir::new(&args.directory)
        .follow_links(true)
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.path().is_file())
        .map(|e| e.path().to_path_buf())
        .collect();
    println!("Found {} files", files.len());
    
    // Process files in parallel
    files.par_iter().for_each(|path| {
        if let Ok(matches) = scan_file(path, &args.uuid, &uuid_regex, args.verbose) {
            found_count.fetch_add(matches, Ordering::Relaxed);
        }
    });
    
    println!("\nTotal matches found: {}", found_count.load(Ordering::Relaxed));
    
    Ok(())
}

fn scan_file(path: &Path, uuid: &str, uuid_regex: &Regex, verbose: bool) -> Result<usize> {
    let mut file = File::open(path)?;
    let mut data = Vec::new();
    file.read_to_end(&mut data)?;
    
    // First, try to parse as NBT
    if let Ok(nbt_value) = from_reader::<_, nbt::Value>(&mut &data[..]) {
        if search_nbt_value(&nbt_value, &uuid.to_lowercase()) {
            if verbose {
                println!("Found UUID in NBT file: {}", path.display());
            } else {
                println!("Found UUID in NBT file: {}", 
                    path.file_name().unwrap_or_default().to_string_lossy());
            }
            return Ok(1);
        }
        return Ok(0);
    }
    
    // If NBT parsing failed, try to decompress with gzip and search
    if let Ok(decompressed) = decompress_gzip(&data) {
        return search_text(&decompressed, path, uuid_regex, verbose);
    }
    
    // If decompression failed, just search the raw data
    search_text(&data, path, uuid_regex, verbose)
}

fn decompress_gzip(data: &[u8]) -> Result<Vec<u8>> {
    let mut decoder = GzDecoder::new(data);
    let mut decompressed = Vec::new();
    decoder.read_to_end(&mut decompressed)?;
    Ok(decompressed)
}

fn search_text(data: &[u8], path: &Path, uuid_regex: &Regex, verbose: bool) -> Result<usize> {
    let content = String::from_utf8_lossy(data);
    let mut matches = 0;
    
    for (line_num, line) in content.lines().enumerate() {
        if uuid_regex.is_match(line) {
            matches += 1;
            if verbose {
                println!("Found in {} (line {}): {}", 
                    path.display(), 
                    line_num + 1, 
                    line.trim()
                );
            } else {
                println!("Found in {} (line {})", 
                    path.file_name().unwrap_or_default().to_string_lossy(), 
                    line_num + 1
                );
            }
        }
    }
    
    Ok(matches)
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
