# Automated Daily Tracker API with Serverless Backups
**Cloud DevOps Engineer Practical Project**

This project demonstrates core DevOps skills: Linux, Python, Docker, CI/CD (GitHub Actions), and AWS (EC2, S3, IAM, Cron).

## Phase 1: Application & Containerization
1. **app.py**: A simple Flask API that accepts a JSON payload and writes it to a local text file.
2. **requirements.txt**: Python dependencies.
3. **Dockerfile**: Containerizes the application using a lightweight Python image.

## Phase 2: Core Infrastructure (AWS EC2)
1. Launch an AWS EC2 instance (Ubuntu or Amazon Linux 2023).
2. Create a Security Group allowing SSH (Port 22) and Custom TCP (Port 8080).
3. Connect via SSH and install Docker (if not installed). Add your user to the Docker group:
   ```bash
   sudo usermod -aG docker $USER
   ```

## Phase 3: CI/CD (Continuous Deployment)
1. Push your code to a GitHub repository.
2. Add the following **Repository Secrets** in GitHub:
   - `EC2_HOST`: The Public IP of your EC2 instance.
   - `EC2_USERNAME`: Your EC2 username (e.g., `ubuntu` or `ec2-user`).
   - `EC2_SSH_KEY`: The contents of your `.pem` key file.
3. The `.github/workflows/deploy.yml` will automatically trigger on a push to `main`, SSH into your server, and execute `deploy.sh`.
4. `deploy.sh` handles pulling code, building the image, stopping the old container, and running the new one with a **Bind Mount** so data stays on the EC2 host.

## Phase 4: Serverless Automation & Backups (AWS IAM & S3)
1. Create an S3 Bucket (e.g., `my-tracker-backups`).
2. Create an IAM Role for EC2 with `AmazonS3FullAccess`.
3. Attach the IAM Role to your EC2 instance.
4. Schedule `backup.sh` on your EC2 instance using Linux `cron`:
   ```bash
   crontab -e
   # Add this line to run exactly at midnight every night:
   0 0 * * * /app/Aws-learn/backup.sh
   ```

## Teardown (To avoid AWS Charges)
1. Terminate the EC2 Instance.
2. Empty and delete the S3 Bucket.
3. Delete the IAM Role and Security Group.
