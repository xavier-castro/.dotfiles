#!/bin/bash

# Video optimization script for web
# Usage: ./optimize-video.sh <input_video>

# Check if input file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_video>"
    echo "Example: $0 video.mp4"
    exit 1
fi

input_file="$1"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

# Get filename without extension and directory
filename=$(basename -- "$input_file")
name="${filename%.*}"
extension="${filename##*.}"
dir=$(dirname "$input_file")

# Output filenames
output_720p="${dir}/${name}_optimized.${extension}"
output_1080p="${dir}/${name}_optimized_1080p.${extension}"

echo "🎬 Optimizing video: $input_file"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Create 720p version (default)
echo "📹 Creating 720p optimized version..."
ffmpeg -i "$input_file" -vf scale=1280:720 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k -movflags +faststart -y "$output_720p" -loglevel error -stats

# Ask if user wants 1080p version too
echo ""
read -p "💡 Also create 1080p version? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📹 Creating 1080p optimized version..."
    ffmpeg -i "$input_file" -vf scale=1920:1080 -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 128k -movflags +faststart -y "$output_1080p" -loglevel error -stats
fi

echo ""
echo "✅ Optimization complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Show file sizes
echo "📊 File size comparison:"
original_size=$(du -h "$input_file" | cut -f1)
optimized_size=$(du -h "$output_720p" | cut -f1)
echo "   Original: $original_size"
echo "   720p optimized: $optimized_size"

if [ -f "$output_1080p" ]; then
    optimized_1080p_size=$(du -h "$output_1080p" | cut -f1)
    echo "   1080p optimized: $optimized_1080p_size"
fi

echo ""
echo "📁 Output files:"
echo "   $output_720p"
if [ -f "$output_1080p" ]; then
    echo "   $output_1080p"
fi