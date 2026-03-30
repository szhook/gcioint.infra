#!/bin/bash

# Define variables
REPO_PATH="/home/site/prod/web/stage"  # Your project's directory
BRANCH="stage"  # The branch you want to deploy
GIT_USER="Autodeploy"           # Optional: Git username
GIT_EMAIL="dev@inxl.io" # Optional: Git email

# Navigate to your repository
cd $REPO_PATH || exit

# Reset any local changes and fetch the latest from the remote branch
git reset --hard
git clean -fd
git fetch origin $BRANCH
git checkout $BRANCH
git pull origin $BRANCH

# Set Git user details if necessary (for logging purposes)
#git config user.name "$GIT_USER"
#git config user.email "$GIT_EMAIL"

# Run any additional deployment tasks (e.g., building assets)
# npm install && npm run build

# Restart necessary services, if needed
# systemctl restart nginx

echo "Deployment of $BRANCH completed!"
