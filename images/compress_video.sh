#!/bin/bash

# Script to create compressed versions of video-1.mp4
# Creates 3 versions with different compression levels

echo "Creating compressed versions of video-1.mp4..."

# Check if video-1.mp4 exists
if [ ! -f "video-1.mp4" ]; then
    echo "Error: video-1.mp4 not found in current directory"
    exit 1
fi

# Get original file size
ORIGINAL_SIZE=$(stat -c%s video-1.mp4)
echo "Original file size: $ORIGINAL_SIZE bytes ($(echo "scale=1; $ORIGINAL_SIZE / 1024 / 1024" | bc) MB)"

# Calculate target sizes
TARGET_50=$(($ORIGINAL_SIZE / 2))
TARGET_10=$(($ORIGINAL_SIZE / 10))
TARGET_5=$(($ORIGINAL_SIZE / 20))

echo "Target sizes:"
echo "  video-2.mp4 (50%): $TARGET_50 bytes ($(echo "scale=1; $TARGET_50 / 1024 / 1024" | bc) MB)"
echo "  video-3.mp4 (10%): $TARGET_10 bytes ($(echo "scale=1; $TARGET_10 / 1024 / 1024" | bc) MB)"
echo "  video-4.mp4 (5%):  $TARGET_5 bytes ($(echo "scale=1; $TARGET_5 / 1024 / 1024" | bc) MB)"

# Create video-2.mp4 (50% of original size)
echo "Creating video-2.mp4 (50% target)..."
ffmpeg -i video-1.mp4 -c:v mpeg4 -q:v 15 -an video-2.mp4 -y
VIDEO2_SIZE=$(stat -c%s video-2.mp4)
VIDEO2_PERCENT=$(echo "scale=1; $VIDEO2_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $VIDEO2_SIZE bytes ($(echo "scale=1; $VIDEO2_SIZE / 1024 / 1024" | bc) MB - $VIDEO2_PERCENT% of original)"

# Create video-3.mp4 (10% of original size)
echo "Creating video-3.mp4 (10% target)..."
ffmpeg -i video-1.mp4 -c:v mpeg4 -q:v 25 -vf scale=iw/2:ih/2 -an video-3.mp4 -y
VIDEO3_SIZE=$(stat -c%s video-3.mp4)
VIDEO3_PERCENT=$(echo "scale=1; $VIDEO3_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $VIDEO3_SIZE bytes ($(echo "scale=1; $VIDEO3_SIZE / 1024 / 1024" | bc) MB - $VIDEO3_PERCENT% of original)"

# Create video-4.mp4 (5% of original size)
echo "Creating video-4.mp4 (5% target)..."
ffmpeg -i video-1.mp4 -c:v mpeg4 -q:v 31 -vf scale=iw/3:ih/3 -an video-4.mp4 -y
VIDEO4_SIZE=$(stat -c%s video-4.mp4)
VIDEO4_PERCENT=$(echo "scale=1; $VIDEO4_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $VIDEO4_SIZE bytes ($(echo "scale=1; $VIDEO4_SIZE / 1024 / 1024" | bc) MB - $VIDEO4_PERCENT% of original)"

echo
echo "Summary:"
echo "Original: $ORIGINAL_SIZE bytes ($(echo "scale=1; $ORIGINAL_SIZE / 1024 / 1024" | bc) MB)"
echo "video-2.mp4: $VIDEO2_SIZE bytes ($(echo "scale=1; $VIDEO2_SIZE / 1024 / 1024" | bc) MB - $VIDEO2_PERCENT% of original)"
echo "video-3.mp4: $VIDEO3_SIZE bytes ($(echo "scale=1; $VIDEO3_SIZE / 1024 / 1024" | bc) MB - $VIDEO3_PERCENT% of original)"
echo "video-4.mp4: $VIDEO4_SIZE bytes ($(echo "scale=1; $VIDEO4_SIZE / 1024 / 1024" | bc) MB - $VIDEO4_PERCENT% of original)"

echo
echo "Verifying files..."
file video-*.mp4

echo
echo "Video compression complete!"
