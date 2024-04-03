#!/usr/bin/env bash 

#Install Nginx if it not already installed
sudo apt update
sudo apt install nginx

#Create the folders
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
#Create a fake HTML file /data/web_static/releases/test/index.html (with simple content, to test your Nginx configuration)
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >> /data/web_static/releases/test/index.html

#Create a symbolic link
ln -sf /data/web_static/releases/test/ /data/web_static/current

#Give ownership of the /data/ folder 
sudo chown -R ubuntu:ubuntu /data/

#Update the Nginx configuration 
config="location /hbnb_static/ {
	alias /data/web_static/current/;
	index index.html
}
"
sudo sed -i "36i $config" /etc/nginx/sites-available/default
#Use alias inside your Nginx configuration
sudo service nginx restart
exit 0

