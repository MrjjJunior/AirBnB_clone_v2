#!/usr/bin/env bash 

#installing nginx
sudo apt update
sudo apt install ngnix 

#creating required file and folder
mkdir -p data/web_static/releases/test/ data/web_static/shared/

sudo echo "
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

#creating a symbolic link
sudo ln -s /data/web_static/releases/test/ /data/web_static/current

#changing ownership
sudo chown -R ubuntu:ubuntu /data
sudo ls -l /data # verifying change

