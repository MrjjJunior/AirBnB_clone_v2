#!/usr/bin/env bash 

# Install Nginx if it not already installed
if ! dpkg -l | grep -q nginx; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

sudo ufw allow 'Nginx HTTP'

mkdir -p /data/
mkdir -p /data/web_static/
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

sudo echo "
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -hR ubuntu:ubuntu /data

sudo ls -l /data

sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo service nginx start
