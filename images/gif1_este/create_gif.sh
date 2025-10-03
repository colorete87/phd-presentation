#!/bin/bash

# Script to create a GIF from snapshot images
# Usage: ./create_gif.sh [output_filename] [delay]

# Set default values
OUTPUT_FILE="${1:-../6g-qat.gif}"
DELAY="${2:-20}"

echo "Creating GIF from snapshot images..."
echo "Output file: $OUTPUT_FILE"
echo "Delay between frames: $DELAY/100 seconds"

# Check if ImageMagick is available
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick 'convert' command not found. Please install ImageMagick."
    exit 1
fi

# Check if snapshot images exist
if [ ! -f "snapshot_00000.png" ]; then
    echo "Error: No snapshot images found in current directory."
    exit 1
fi

# Count the number of snapshot images
IMAGE_COUNT=$(ls snapshot_*.png 2>/dev/null | wc -l)
echo "Found $IMAGE_COUNT snapshot images"

# Create the GIF
convert -delay "$DELAY" -loop 0 snapshot_*.png "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "GIF created successfully: $OUTPUT_FILE"
    ls -lh "$OUTPUT_FILE"
else
    echo "Error: Failed to create GIF"
    exit 1
fi
