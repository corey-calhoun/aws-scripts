#!/bin/bash

################################################################################
# Author: Corey Calhoun
# Date: 03-31-2023
# Description: Filetype search for AWS S3 buckets.
# Usage: ./filetype-serach.sh 
################################################################################

bucket_name="my-s3-bucket"
file_type=".txt"
local_dir="/path/to/local/dir/"

aws s3 ls s3://$bucket_name --recursive | grep $file_type | awk '{print $4}' | while read file; do
    aws s3 cp s3://$bucket_name/$file $local_dir
done
