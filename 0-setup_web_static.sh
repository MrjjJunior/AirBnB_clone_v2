#!/usr/bin/env bash 

#installing nginx
sudo apt update
sudo apt install ngnix 

#creating required file and folder
mkdir -p data/web_static/releases/test/ data/web_static/shared/

touch data/web_static/releases/test/index.html

