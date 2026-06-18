#!/bin/bash                                                                                                                            
                                                                                                                                        
# Exit immediately if a command fails                                                                                                  
set -e                                                                                                                                 
                                                                                                                                        
# Define variables                                                                                                                     
PROJECT_DIR="$HOME/Aws-learn"                                                                                                          
IMAGE_NAME="tracker-api-image"                                                                                                         
CONTAINER_NAME="tracker-container"                                                                                                     
                                                                                                                                        
echo "Navigating to project directory..."                                                                                              
cd $PROJECT_DIR                                                                                                                        
                                                                                                                                        
echo "Pulling latest code from GitHub..."                                                                                              
git pull origin main                                                                                                                   
                                                                                                                                        
echo "Building the Docker image..."                                                                                                    
sudo docker build -t $IMAGE_NAME:latest .                                                                                              
                                                                                                                                        
echo "Stopping and removing old container (if exists)..."                                                                              
sudo docker stop $CONTAINER_NAME || true                                                                                               
sudo docker rm $CONTAINER_NAME || true                                                                                                 
                                                                                                                                        
echo "Starting the new container with a Bind Mount (sync)..."                                                                          
# The -v flag syncs the EC2 folder to the container's /app folder                                                                      
sudo docker run -d --name $CONTAINER_NAME -p 80:80 -v $PROJECT_DIR:/app $IMAGE_NAME:latest                                                                                                               
                                                                                                                                        
echo "Deployment complete!"  