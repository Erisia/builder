import os
import subprocess
import shutil

# --- Configuration ---
# Set the directory containing your .ogg files (including subdirectories).
# Use "." for the current directory where you save and run the script.
INPUT_AUDIO_DIRECTORY = "." 

# Set the directory where the recompressed files will be saved.
# The script will create this directory.
# WARNING: If this directory already exists, IT WILL BE DELETED AND RECREATED
# to ensure a clean run each time you experiment with quality settings.
OUTPUT_AUDIO_DIRECTORY = "recompressed_ogg_files"

# Adjust this quality level for FFmpeg's libvorbis encoder.
# The -q:a scale for libvorbis in FFmpeg typically ranges from 0 to 10.
# Lower numbers = smaller files, lower quality.
# Higher numbers = larger files, better quality.
# A good starting point might be 3, 4, or 5. You'll need to experiment.
# For a reduction from 128MB to <90MB, you might start with QUALITY = 6
QUALITY = 6
# --- End Configuration ---

def recompress_ogg_audio(input_dir, output_dir, quality_level):
    """
    Recursively finds .ogg files in input_dir, recompresses them using FFmpeg,
    and saves them to output_dir, maintaining the subdirectory structure.

    Args:
        input_dir (str): The path to the directory containing original .ogg files.
        output_dir (str): The path to the directory where recompressed files will be saved.
        quality_level (int): The FFmpeg quality level for libvorbis (-q:a).
    """

    # Ensure FFmpeg is available
    if shutil.which("ffmpeg") is None:
        print("Error: ffmpeg command not found. Please ensure FFmpeg is installed and in your PATH.")
        return

    # Clean up and create the main output directory
    if os.path.exists(output_dir):
        print(f"Removing existing output directory: {os.path.abspath(output_dir)}")
        try:
            shutil.rmtree(output_dir)
        except OSError as e:
            print(f"Error removing directory {output_dir}: {e}")
            return
    try:
        os.makedirs(output_dir)
        print(f"Created output directory: {os.path.abspath(output_dir)}")
    except OSError as e:
        print(f"Error creating directory {output_dir}: {e}")
        return

    file_count = 0
    recompressed_count = 0

    for root, dirs, files in os.walk(input_dir):
        # Avoid processing the output directory itself if it's a subdirectory of input_dir
        if os.path.abspath(root).startswith(os.path.abspath(output_dir)):
            continue

        for file in files:
            if file.lower().endswith(".ogg"):
                file_count += 1
                input_file_path = os.path.join(root, file)
                
                # Determine the relative path to maintain directory structure
                relative_path_from_input_root = os.path.relpath(root, input_dir)
                
                # Construct the output subdirectory path
                if relative_path_from_input_root == ".":
                    current_output_subdir = output_dir
                else:
                    current_output_subdir = os.path.join(output_dir, relative_path_from_input_root)
                
                # Create the output subdirectory if it doesn't exist
                if not os.path.exists(current_output_subdir):
                    try:
                        os.makedirs(current_output_subdir)
                    except OSError as e:
                        print(f"Error creating subdirectory {current_output_subdir}: {e}")
                        continue # Skip this file if subdir creation fails
                
                output_file_path = os.path.join(current_output_subdir, file)

                print(f"\nProcessing: {input_file_path}")
                
                ffmpeg_command = [
                    "ffmpeg",
                    "-i", input_file_path,
                    "-c:a", "libvorbis",      # Specify Ogg Vorbis encoder
                    "-q:a", str(quality_level), # Set the quality level
                    "-y",                      # Overwrite output files without asking
                    output_file_path
                ]

                try:
                    # Using Popen to potentially handle large outputs better,
                    # but communicate() will wait for completion.
                    process = subprocess.Popen(ffmpeg_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    stdout, stderr = process.communicate() # Wait for the process to complete
                    
                    if process.returncode == 0:
                        print(f"Successfully recompressed to: {output_file_path}")
                        recompressed_count +=1
                    else:
                        print(f"Error recompressing {input_file_path}:")
                        # stderr from ffmpeg can be quite verbose, so print it if there's an error
                        print(stderr.decode(errors='ignore')) # Use errors='ignore' for robustness
                        
                except Exception as e:
                    print(f"An unexpected error occurred while processing {input_file_path}: {e}")
    
    if file_count == 0:
        print("No .ogg files found in the input directory.")
    else:
        print(f"\nProcessed {file_count} .ogg files. Successfully recompressed {recompressed_count} files.")


if __name__ == "__main__":
    abs_input_dir = os.path.abspath(INPUT_AUDIO_DIRECTORY)
    abs_output_dir = os.path.abspath(OUTPUT_AUDIO_DIRECTORY)

    if not os.path.isdir(abs_input_dir):
        print(f"Error: Input directory '{abs_input_dir}' does not exist or is not a directory.")
    else:
        print(f"Starting Ogg Vorbis recompression...")
        print(f"Source directory:      {abs_input_dir}")
        print(f"Output directory:      {abs_output_dir}")
        print(f"Target quality (-q:a): {QUALITY}")
        print("---")
        
        recompress_ogg_audio(abs_input_dir, abs_output_dir, QUALITY)
        
        print("\n---")
        print("Recompression process finished.")
        print(f"Please check the '{abs_output_dir}' directory for the recompressed files and their total size.")
        print("If the total size is not below your 90MB target or the quality is not acceptable:")
        print(f"1. The '{abs_output_dir}' directory would have been cleared on the next run.")
        print(f"2. Adjust the 'QUALITY = {QUALITY}' variable in the script (e.g., decrease for smaller size, increase for better quality).")
        print("3. Run the script again.")
