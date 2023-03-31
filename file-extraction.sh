#!/bin/bash

################################################################################
# Author: Corey Calhoun
# Date: 03-31-2023
# Description: Filetype search and extraction script for AWS S3 buckets.
# Usage: ./file-extraction.sh
################################################################################

# Ask the user for the S3 bucket name
read -p "Enter the S3 bucket name: " bucket_name

# Ask the user for the file type to search for
read -p "Enter the file type to search for (without leading dot): " file_type

# Ask the user for the destination directory to copy the files to
read -p "Enter the destination directory: " destination_dir

# Search for the files in the S3 bucket with the specified file type
search_results=$(aws s3 ls s3://$bucket_name | grep ".$file_type")

# Check if files were found
if [[ -n $search_results ]]; then
  # Print a message to user
  echo "Copying files with .$file_type extension to $destination_dir..."
    # List the files and copy them to the destination directory
    aws s3 ls s3://$bucket_name --recursive | grep ".$file_type" | awk '{print $4}' | xargs -I {} aws s3 cp s3://$bucket_name/{} $destination_dir
else
  echo "No files found with extension .$file_type"
fi 
