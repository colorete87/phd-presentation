#!/bin/bash

# Script to create compressed versions of nina-1.jpg
# Creates 3 versions with different compression levels

echo "Creating compressed versions of nina-1.jpg..."

# Get original file size
ORIGINAL_SIZE=$(stat -c%s nina-1.jpg)
echo "Original file size: $ORIGINAL_SIZE bytes"

# Calculate target sizes
TARGET_50=$(($ORIGINAL_SIZE / 2))
TARGET_10=$(($ORIGINAL_SIZE / 10))
TARGET_5=$(($ORIGINAL_SIZE / 20))

echo "Target sizes:"
echo "  nina-2.jpg (50%): $TARGET_50 bytes"
echo "  nina-3.jpg (10%): $TARGET_10 bytes"
echo "  nina-4.jpg (5%):  $TARGET_5 bytes"

# Create nina-2.jpg (50% of original size)
echo "Creating nina-2.jpg (50% target)..."
magick nina-1.jpg -quality 48 nina-2.jpg
NINA2_SIZE=$(stat -c%s nina-2.jpg)
NINA2_PERCENT=$(echo "scale=1; $NINA2_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $NINA2_SIZE bytes ($NINA2_PERCENT% of original)"

# Create nina-3.jpg (10% of original size)
echo "Creating nina-3.jpg (10% target)..."
magick nina-1.jpg -quality 12 nina-3.jpg
NINA3_SIZE=$(stat -c%s nina-3.jpg)
NINA3_PERCENT=$(echo "scale=1; $NINA3_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $NINA3_SIZE bytes ($NINA3_PERCENT% of original)"

# Create nina-4.jpg (5% of original size)
echo "Creating nina-4.jpg (5% target)..."
magick nina-1.jpg -quality 5 nina-4.jpg
NINA4_SIZE=$(stat -c%s nina-4.jpg)
NINA4_PERCENT=$(echo "scale=1; $NINA4_SIZE * 100 / $ORIGINAL_SIZE" | bc)
echo "  Result: $NINA4_SIZE bytes ($NINA4_PERCENT% of original)"

echo
echo "Summary:"
echo "Original: $ORIGINAL_SIZE bytes"
echo "nina-2.jpg: $NINA2_SIZE bytes ($NINA2_PERCENT% of original)"
echo "nina-3.jpg: $NINA3_SIZE bytes ($NINA3_PERCENT% of original)"
echo "nina-4.jpg: $NINA4_SIZE bytes ($NINA4_PERCENT% of original)"

echo
echo "Verifying files..."
file nina-*.jpg

echo
echo "Compression complete!"
