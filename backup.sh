#!/bin/bash

# Use the AWS CLI to copy the file to S3. 
# Note: We don't need credentials here because the EC2 IAM role handles it securely!
# Change 'my-tracker-backups' to your actual S3 bucket name

aws s3 cp $HOME/Aws-learn/tasks.txt s3://my-tracker-backups/tasks-backup-$(date +%F).txt
