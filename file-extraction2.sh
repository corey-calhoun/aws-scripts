#!/bin/bash

################################################################################
# Author: Corey Calhoun
# Date: 03-31-2023
# Description: Filetype search and extraction script for AWS S3 buckets.
# Usage: ./file-extraction2.sh
################################################################################

# Prompt user for input
read -p "Enter S3 bucket name: " bucket_name
read -p "Enter file type to search (e.g. '.txt'): " file_type
read -p "Enter local directory path to copy files to: " local_dir

# List files in S3 bucket recursively and filter by file type
aws s3 ls s3://$bucket_name --recursive | grep $file_type | awk '{print $4}' | while read file; do
    # Copy file to local directory
    aws s3 cp s3://$bucket_name/$file $local_dir
done