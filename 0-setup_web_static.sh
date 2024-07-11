#!/usr/bin/env bash 

# installing nginx
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install nginx


# creating required file and folder
mkdir -p data/web_static/releases/test/ data/web_static/shared/

sudo echo "
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# creating a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# changing ownership
sudo chown -hR ubuntu:ubuntu /data
sudo ls -l /data # verifying change
# configuring nginx
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
# starting nginx
sudo service nginx start
