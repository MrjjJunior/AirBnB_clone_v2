#!/usr/bin/env bash 

#Install Nginx if it not already installed
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install nginx

#Create the folders
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

echo "This is a test" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data/
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
sudo service nginx start

'''#Create a fake HTML file /data/web_static/releases/test/index.html (with simple content, to test your Nginx configuration)
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >> /data/web_static/releases/test/index.html

#Create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

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
sudo service nginx start
exit 0'''

