use anyhow::{Context, Result};
use clap::Parser;
use flate2::read::GzDecoder;
use nbt::de::{from_gzip_reader, from_reader};
use rayon::prelude::*;
use regex::Regex;
use serde_json::Value as JsonValue;
use std::collections::HashMap;
use std::fs::{File, metadata};
use std::io::Read;
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

#[derive(Debug, Clone)]
struct Match {
    file_path: PathBuf,
    size: Option<usize>,
    percentile: Option<f64>,
    match_type: MatchType,
    location: String,
}

#[derive(Debug, Clone)]
enum MatchType {
    NbtKey(String),
    NbtValue(String),
    JsonKey(String),
    JsonValue(String),
    TextMatch(String),
    FilenameMatch(String),
}

fn load_nbt_from_file(path: &Path) -> Result<nbt::Map<String, nbt::Value>> {
    let file = File::open(path)?;
    
    // Try to read as gzipped NBT first
    match from_gzip_reader(file) {
        Ok(compound) => Ok(compound),
        Err(_) => {
            // If gzip fails, try reading as uncompressed NBT
            let file = File::open(path)?;
            from_reader(file).context("Failed to parse NBT data")
        }
    }
}

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    #[arg(help = "The UUID to search for")]
    uuid: String,

    #[arg(help = "Directory to scan")]
    directory: PathBuf,

    #[arg(short, long, help = "Print individual matches")]
    verbose: bool,
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
    let mut file_totals: HashMap<&PathBuf, (usize, Option<usize>, Vec<f64>)> = HashMap::new();
    
    for match_item in &sorted_matches {
        let entry = file_totals.entry(&match_item.file_path).or_insert((0, None, Vec::new()));
        entry.0 += 1; // Count of matches
        
        if let Some(size) = match_item.size {
            *entry.1.get_or_insert(0) += size; // Sum NBT sizes
        }
        
        if let Some(percentile) = match_item.percentile {
            entry.2.push(percentile); // Collect percentiles
        }
    }
    
    // Print sorted results
    let mut sorted_files: Vec<_> = file_totals.into_iter().collect();
    sorted_files.sort_by(|a, b| {
        // Sort by estimated size first (ascending), then by file path (ascending)
        match (a.1.1, b.1.1) {
            (Some(size_a), Some(size_b)) => {
                size_a.cmp(&size_b).then_with(|| a.0.cmp(b.0))
            }
            (Some(_), None) => std::cmp::Ordering::Greater,
            (None, Some(_)) => std::cmp::Ordering::Less,
            (None, None) => a.0.cmp(b.0),
        }
    });
    
    if args.verbose {
        // Print individual matches
        for match_item in &sorted_matches {
            let mut output = format!("{}", match_item.file_path.display());
            output.push_str(" - ");
            output.push_str(&match_item.location);
            
            match &match_item.match_type {
                MatchType::NbtKey(key) => output.push_str(&format!(" (NBT key: {})", key)),
                MatchType::NbtValue(desc) => output.push_str(&format!(" (NBT value: {})", desc)),
                MatchType::JsonKey(key) => output.push_str(&format!(" (JSON key: {})", key)),
                MatchType::JsonValue(val) => output.push_str(&format!(" (JSON value: {})", val)),
                MatchType::TextMatch(line) => output.push_str(&format!(" (text: {})", line.trim())),
                MatchType::FilenameMatch(filename) => output.push_str(&format!(" (filename: {})", filename)),
            }
            
            if let (Some(size), Some(percentile)) = (match_item.size, match_item.percentile) {
                output.push_str(&format!(" [size: {} bytes, percentile: {:.1}%]", size, percentile));
            }
            
            println!("{}", output);
        }
    } else {
        // Print summary by file
        for (file_path, (count, total_size, percentiles)) in sorted_files {
            let mut output = format!("{}", file_path.display());
            
            output.push_str(" (");
            
            let mut parts = Vec::new();
            
            if let Some(size) = total_size {
                parts.push(format!("size: {} bytes", size));
            }
            
            parts.push(format!("{} matches", count));
            
            if !percentiles.is_empty() {
                let percentile_str: Vec<String> = percentiles.iter()
                    .map(|p| format!("{:.1}%", p))
                    .collect();
                parts.push(format!("percentiles: [{}]", percentile_str.join(", ")));
            }
            
            output.push_str(&parts.join(", "));
            output.push(')');
            println!("{}", output);
        }
    }
    
    println!("\nTotal matches found: {}", sorted_matches.len());
    
    Ok(())
}

fn get_sibling_file_sizes(file_path: &Path) -> Result<Vec<u64>> {
    let parent_dir = file_path.parent().ok_or_else(|| anyhow::anyhow!("No parent directory"))?;
    let mut sizes = Vec::new();
    
    for entry in std::fs::read_dir(parent_dir)? {
        let entry = entry?;
        if entry.path().is_file() {
            if let Ok(metadata) = entry.metadata() {
                sizes.push(metadata.len());
            }
        }
    }
    
    Ok(sizes)
}

fn calculate_file_percentile(target_size: u64, all_sizes: &[u64]) -> f64 {
    if all_sizes.is_empty() {
        return 0.0;
    }
    
    let smaller_count = all_sizes.iter().filter(|&&size| size < target_size).count();
    (smaller_count as f64 / all_sizes.len() as f64) * 100.0
}

fn scan_file(path: &Path, uuid: &str, uuid_regex: &Regex, base_dir: &Path) -> Result<Vec<Match>> {
    let mut file = File::open(path)?;
    let mut data = Vec::new();
    file.read_to_end(&mut data)?;
    
    let relative_path = path.strip_prefix(base_dir).unwrap_or(path).to_path_buf();
    let mut matches = Vec::new();
    
    // First, check if the filename contains the UUID
    if let Some(filename) = path.file_name().and_then(|f| f.to_str()) {
        if uuid_regex.is_match(filename) {
            // Get file size and sibling file sizes for percentile calculation
            if let Ok(file_metadata) = metadata(path) {
                let file_size = file_metadata.len();
                
                if let Ok(sibling_sizes) = get_sibling_file_sizes(path) {
                    let percentile = calculate_file_percentile(file_size, &sibling_sizes);
                    
                    matches.push(Match {
                        file_path: relative_path.clone(),
                        size: Some(file_size as usize),
                        percentile: Some(percentile),
                        match_type: MatchType::FilenameMatch(filename.to_string()),
                        location: "filename".to_string(),
                    });
                } else {
                    // If we can't get sibling sizes, still record the filename match
                    matches.push(Match {
                        file_path: relative_path.clone(),
                        size: Some(file_size as usize),
                        percentile: None,
                        match_type: MatchType::FilenameMatch(filename.to_string()),
                        location: "filename".to_string(),
                    });
                }
            }
        }
    }
    
    // Then, try to parse as NBT using our reusable function
    if let Ok(nbt_compound) = load_nbt_from_file(path) {
        let nbt_matches = search_nbt_map(&nbt_compound, &uuid.to_lowercase());
        if !nbt_matches.is_empty() {
            let mut content_matches: Vec<Match> = nbt_matches.into_iter().map(|(size, percentile, match_type, location)| Match {
                file_path: relative_path.clone(),
                size: Some(size),
                percentile: Some(percentile),
                match_type,
                location,
            }).collect();
            matches.append(&mut content_matches);
        }
        return Ok(matches);
    }
    
    // If NBT parsing failed, try JSON parsing
    if let Ok(content) = std::str::from_utf8(&data) {
        if let Ok(json_value) = serde_json::from_str::<JsonValue>(content) {
            let json_matches = search_json_value(&json_value, &uuid.to_lowercase());
            if !json_matches.is_empty() {
                let mut content_matches: Vec<Match> = json_matches.into_iter().map(|(size, percentile, match_type, location)| Match {
                    file_path: relative_path.clone(),
                    size: Some(size),
                    percentile: Some(percentile),
                    match_type,
                    location,
                }).collect();
                matches.append(&mut content_matches);
            }
            return Ok(matches);
        }
    }
    
    // If JSON parsing failed, try to decompress with gzip and search
    if let Ok(decompressed) = decompress_gzip(&data) {
        if let Ok(mut text_matches) = search_text(&decompressed, &relative_path, uuid_regex) {
            matches.append(&mut text_matches);
        }
        return Ok(matches);
    }
    
    // If decompression failed, just search the raw data
    if let Ok(mut text_matches) = search_text(&data, &relative_path, uuid_regex) {
        matches.append(&mut text_matches);
    }
    Ok(matches)
}

fn decompress_gzip(data: &[u8]) -> Result<Vec<u8>> {
    let mut decoder = GzDecoder::new(data);
    let mut decompressed = Vec::new();
    decoder.read_to_end(&mut decompressed)?;
    Ok(decompressed)
}

fn search_text(data: &[u8], file_path: &PathBuf, uuid_regex: &Regex) -> Result<Vec<Match>> {
    let content = String::from_utf8_lossy(data);
    let mut matches = Vec::new();
    
    for (line_num, line) in content.lines().enumerate() {
        if uuid_regex.is_match(line) {
            matches.push(Match {
                file_path: file_path.clone(),
                size: None,
                percentile: None,
                match_type: MatchType::TextMatch(line.to_string()),
                location: format!("line {}", line_num + 1),
            });
        }
    }
    
    Ok(matches)
}

fn estimate_json_size(value: &JsonValue) -> usize {
    match value {
        JsonValue::Null => 4, // "null"
        JsonValue::Bool(b) => if *b { 4 } else { 5 }, // "true" or "false"
        JsonValue::Number(n) => n.to_string().len(),
        JsonValue::String(s) => 2 + s.len(), // quotes + content
        JsonValue::Array(arr) => {
            2 + arr.iter().map(|v| estimate_json_size(v)).sum::<usize>() + 
            if arr.len() > 1 { arr.len() - 1 } else { 0 } // brackets + commas
        }
        JsonValue::Object(map) => {
            let content_size: usize = map.iter()
                .map(|(k, v)| 3 + k.len() + estimate_json_size(v)) // "key": + value
                .sum();
            let comma_size = if map.len() > 1 { map.len() - 1 } else { 0 };
            2 + content_size + comma_size // braces + content + commas
        }
    }
}

fn search_json_value(value: &JsonValue, uuid: &str) -> Vec<(usize, f64, MatchType, String)> {
    match value {
        JsonValue::Object(map) => search_json_object(map, uuid),
        _ => {
            // For non-object root values, just check if they contain the UUID
            if let Some(match_size) = get_json_match_size(value, uuid) {
                vec![(match_size, 0.0, MatchType::JsonValue(format!("{:?}", value)), "root".to_string())]
            } else {
                vec![]
            }
        }
    }
}

fn search_json_object(map: &serde_json::Map<String, JsonValue>, uuid: &str) -> Vec<(usize, f64, MatchType, String)> {
    let all_key_sizes = get_json_key_sizes_in_map(map);
    let mut matches = Vec::new();
    
    // Check if any key contains the UUID
    for (key, val) in map {
        if key.to_lowercase().contains(uuid) {
            let match_size = 3 + key.len() + estimate_json_size(val); // Size of entire key-value pair
            let target_size = match_size; // Same as match_size for percentile calculation
            let percentile = calculate_percentile(target_size, &all_key_sizes);
            matches.push((match_size, percentile, MatchType::JsonKey(key.clone()), format!("key: {}", key)));
        }
    }
    
    // Check if any value contains the UUID
    for (key, value) in map {
        if let Some(match_size) = get_json_match_size(value, uuid) {
            let target_size = 3 + key.len() + estimate_json_size(value); // "key": + value
            let percentile = calculate_percentile(target_size, &all_key_sizes);
            matches.push((match_size, percentile, MatchType::JsonValue(format!("{:?}", value)), format!("value at key: {}", key)));
        }
    }
    
    matches
}


fn get_json_key_sizes_in_map(map: &serde_json::Map<String, JsonValue>) -> Vec<usize> {
    map.iter()
        .map(|(key, val)| 3 + key.len() + estimate_json_size(val)) // "key": + value
        .collect()
}

fn get_json_match_size(value: &JsonValue, uuid: &str) -> Option<usize> {
    match value {
        JsonValue::String(s) => {
            if s.to_lowercase().contains(uuid) {
                Some(s.len()) // Size of the matching string
            } else {
                None
            }
        }
        JsonValue::Object(map) => {
            // Check if any key contains the UUID
            for (key, _) in map {
                if key.to_lowercase().contains(uuid) {
                    return Some(key.len());
                }
            }
            // Check if any value contains the UUID
            for (_, val) in map {
                if let Some(size) = get_json_match_size(val, uuid) {
                    return Some(size);
                }
            }
            None
        }
        JsonValue::Array(arr) => {
            for item in arr {
                if let Some(size) = get_json_match_size(item, uuid) {
                    return Some(size);
                }
            }
            None
        }
        _ => None,
    }
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

fn search_nbt_map(map: &nbt::Map<String, nbt::Value>, uuid: &str) -> Vec<(usize, f64, MatchType, String)> {
    let all_key_sizes = get_key_sizes_in_map(map);
    let mut matches = Vec::new();
    
    // Check if any key contains the UUID
    for (key, val) in map {
        if key.to_lowercase().contains(uuid) {
            let match_size = 1 + 2 + key.len() + estimate_nbt_size(val); // Size of entire key-value pair
            let target_size = match_size; // Same as match_size for percentile calculation
            let percentile = calculate_percentile(target_size, &all_key_sizes);
            matches.push((match_size, percentile, MatchType::NbtKey(key.clone()), format!("key: {}", key)));
        }
    }
    
    // Check if any value contains the UUID
    for (key, value) in map {
        if let Some((match_size, value_desc)) = search_nbt_value_with_size(value, uuid) {
            let target_size = 1 + 2 + key.len() + estimate_nbt_size(value);
            let percentile = calculate_percentile(target_size, &all_key_sizes);
            matches.push((match_size, percentile, MatchType::NbtValue(value_desc.clone()), format!("value at key: {}", key)));
        }
    }
    matches
}


fn calculate_percentile(target_size: usize, all_sizes: &[usize]) -> f64 {
    if all_sizes.is_empty() {
        return 0.0;
    }
    
    let smaller_count = all_sizes.iter().filter(|&&size| size < target_size).count();
    (smaller_count as f64 / all_sizes.len() as f64) * 100.0
}

fn get_key_sizes_in_map(map: &nbt::Map<String, nbt::Value>) -> Vec<usize> {
    map.iter()
        .map(|(key, val)| 1 + 2 + key.len() + estimate_nbt_size(val))
        .collect()
}

fn search_nbt_value_with_size(value: &nbt::Value, uuid: &str) -> Option<(usize, String)> {
    use nbt::Value;
    
    match value {
        Value::String(s) => {
            if s.to_lowercase().contains(uuid) {
                Some((s.len(), format!("String: {}", s)))
            } else {
                None
            }
        }
        Value::Compound(map) => {
            // Check if any key contains the UUID
            for (key, _) in map {
                if key.to_lowercase().contains(uuid) {
                    return Some((key.len(), format!("Compound key: {}", key)));
                }
            }
            
            // Check if any value contains the UUID
            for (key, val) in map {
                if let Some((match_size, desc)) = search_nbt_value_with_size(val, uuid) {
                    return Some((match_size, format!("Compound[{}] -> {}", key, desc)));
                }
            }
            None
        }
        Value::List(list) => {
            for (idx, item) in list.iter().enumerate() {
                if let Some((match_size, desc)) = search_nbt_value_with_size(item, uuid) {
                    return Some((match_size, format!("List[{}] -> {}", idx, desc)));
                }
            }
            None
        }
        Value::ByteArray(bytes) => {
            let bytes_u8: Vec<u8> = bytes.iter().map(|&b| b as u8).collect();
            let content = std::string::String::from_utf8_lossy(&bytes_u8);
            if content.to_lowercase().contains(uuid) {
                // Return the length of the matching portion, not the entire byte array
                Some((uuid.len(), format!("ByteArray: {}", content)))
            } else {
                None
            }
        }
        _ => None,
    }
}


#[cfg(test)]
mod tests {
    use super::*;
    use std::path::PathBuf;

    #[test]
    fn test_nbt_deserializer() {
        let test_file = PathBuf::from("testdata/playerdata.dat");
        
        // Test that we can load the NBT file
        let nbt_data = load_nbt_from_file(&test_file)
            .expect("Should be able to load NBT from test file");
        
        // Verify it's a Map with String keys and NBT Values
        assert!(!nbt_data.is_empty(), "NBT data should not be empty");
        
        // Print some info about the loaded data for verification
        println!("Loaded NBT data with {} top-level keys", nbt_data.len());
        for (key, _) in nbt_data.iter().take(5) {
            println!("  Key: {}", key);
        }
        
        // Test that we can search through the data (this exercises the search functions)
        let _search_results = search_nbt_map(&nbt_data, "test_uuid");
        
        println!("NBT deserializer test passed!");
    }

    #[test]
    fn test_json_search() {
        let test_file = PathBuf::from("testdata/json.json");
        
        // Load the JSON file
        let data = std::fs::read(&test_file)
            .expect("Should be able to read JSON test file");
        
        let content = std::str::from_utf8(&data)
            .expect("Should be valid UTF-8");
        
        let json_value = serde_json::from_str::<JsonValue>(content)
            .expect("Should be valid JSON");
        
        // Test searching for a UUID that exists in the file
        let matches = search_json_value(&json_value, "2fc94059-0209-4e20-b2b9-42d38760c811");
        assert!(!matches.is_empty(), "Should find the UUID in JSON");
        
        // Test searching for a partial UUID
        let matches = search_json_value(&json_value, "2fc94059");
        assert!(!matches.is_empty(), "Should find partial UUID in JSON");
        
        // Test searching for a UUID that doesn't exist
        let matches = search_json_value(&json_value, "00000000-0000-0000-0000-000000000000");
        assert!(matches.is_empty(), "Should not find non-existent UUID");
        
        // Test searching for key that contains UUID-like pattern
        let matches = search_json_value(&json_value, "uuid");
        assert!(!matches.is_empty(), "Should find 'uuid' key pattern");
        
        println!("JSON search test passed!");
    }

    #[test]
    fn test_filename_matching() {
        use std::path::PathBuf;
        use regex::Regex;
        
        let test_uuid = "2fc94059-0209-4e20-b2b9-42d38760c811";
        let uuid_regex = Regex::new(&format!(r"(?i){}", regex::escape(test_uuid))).unwrap();
        let test_file = PathBuf::from("testdata/2fc94059-0209-4e20-b2b9-42d38760c811.dat");
        let base_dir = PathBuf::from("testdata");
        
        // Test that we can find filename matches
        let matches = scan_file(&test_file, test_uuid, &uuid_regex, &base_dir)
            .expect("Should be able to scan file");
        
        // Should find at least one match (the filename match)
        assert!(!matches.is_empty(), "Should find filename match");
        
        // Check that we have a FilenameMatch
        let filename_matches: Vec<_> = matches.iter()
            .filter(|m| matches!(m.match_type, MatchType::FilenameMatch(_)))
            .collect();
        
        assert!(!filename_matches.is_empty(), "Should have filename match");
        
        // Verify the match has size and percentile information
        let filename_match = &filename_matches[0];
        assert!(filename_match.size.is_some(), "Filename match should have size");
        assert!(filename_match.percentile.is_some(), "Filename match should have percentile");
        assert_eq!(filename_match.location, "filename");
        
        println!("Filename matching test passed!");
    }
}
