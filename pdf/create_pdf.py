#!/usr/bin/env python3
"""
Script to convert PNG images to PDF with one image per page.
All PNG files in the current directory will be included in the PDF.
"""

import os
import glob
from PIL import Image
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter, A4, landscape
from reportlab.lib.utils import ImageReader
import sys

def create_pdf_from_images():
    """Convert all PNG images in the current directory to a single PDF."""
    
    # Get all PNG files in the current directory
    png_files = sorted(glob.glob("*.png"))
    
    if not png_files:
        print("No PNG files found in the current directory.")
        return False
    
    print(f"Found {len(png_files)} PNG files to convert.")
    
    # Create PDF filename
    pdf_filename = "presentation_slides.pdf"
    
    # Create PDF canvas with landscape orientation
    c = canvas.Canvas(pdf_filename, pagesize=landscape(A4))
    
    for i, png_file in enumerate(png_files, 1):
        print(f"Processing {png_file} ({i}/{len(png_files)})")
        
        try:
            # Open the image
            img = Image.open(png_file)
            
            # Convert to RGB if necessary (in case of RGBA or other formats)
            if img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Get image dimensions
            img_width, img_height = img.size
            
            # Calculate scaling to fit the page while maintaining aspect ratio
            page_width, page_height = landscape(A4)
            
            # Minimal margin for maximum image area
            margin = 20
            available_width = page_width - 2 * margin
            available_height = page_height - 2 * margin
            
            # Calculate scale factor
            scale_x = available_width / img_width
            scale_y = available_height / img_height
            scale = min(scale_x, scale_y)
            
            # Calculate new dimensions
            new_width = img_width * scale
            new_height = img_height * scale
            
            # Center the image on the page
            x = (page_width - new_width) / 2
            y = (page_height - new_height) / 2
            
            # Add the image to the PDF
            c.drawImage(ImageReader(img), x, y, width=new_width, height=new_height)
            
            # Start a new page (except for the last image)
            if i < len(png_files):
                c.showPage()
                
        except Exception as e:
            print(f"Error processing {png_file}: {e}")
            continue
    
    # Save the PDF
    c.save()
    print(f"\nPDF created successfully: {pdf_filename}")
    print(f"Total pages: {len(png_files)}")
    
    return True

def main():
    """Main function."""
    print("PNG to PDF Converter")
    print("=" * 20)
    
    # Check if we're in the right directory
    if not os.path.exists("."):
        print("Error: Cannot access current directory.")
        sys.exit(1)
    
    # Create the PDF
    success = create_pdf_from_images()
    
    if success:
        print("\nConversion completed successfully!")
    else:
        print("\nConversion failed!")
        sys.exit(1)

if __name__ == "__main__":
    main()
