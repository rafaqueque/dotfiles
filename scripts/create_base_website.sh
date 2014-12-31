#!/bin/bash

# Check if there's arguments
if [ $1 ]; then
  website=$1;
  echo "Preparing to create $website configuration files";
  echo "======================================================================================";
else
  echo "Error: You must specify a website name...";
  exit 1;
fi;

# Copy the default configuration and create symlink
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$website
sudo ln -s /etc/nginx/sites-available/$website /etc/nginx/sites-enabled/$website

# Create www folder
echo "* Create 'www' folder for $website";
mkdir /var/www/$website

# Create public_html folder
echo "* Creating 'public_html' for $website";
mkdir /var/www/$website/public_html

# Create git repo
echo "* Creating '.git' bare repo for $website";
mkdir /var/www/$website/$website.git
cd /var/www/$website/$website.git
git init --bare

# Create git-hook
echo "* Creating post-receive git-hook for $website repo";
touch /var/www/$website/$website.git/hooks/post-receive
echo "#!/bin/sh
GIT_WORK_TREE=/var/www/$website/public_html/ git checkout -f" > /var/www/$website/$website.git/hooks/post-receive

# Set permissions to the git-hook file
echo "* Setting permissions...";
chmod +x /var/www/$website/$website.git/hooks/post-receive

echo "======================================================================================";
echo "Done! You can now add this remote to your local repo:";
echo " -- git remote add <remote_name> ssh://root@rafaqueque.com/var/www/$website/$website.git"
echo "======================================================================================";
exit 1;
