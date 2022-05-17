#!/bin/bash

# update
sudo apt-get update -y

#upgrade
sudo apt-get upgrade -y

#install nginx
sudo apt-get install nginx -y

#start nginx
sudo systemctl start nginx

#enable nginx
sudo systemctl enable nginx

cd app/app

#NodeJs
sudo apt-get install python-software-properties -y

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt-get install -y nodejs

sudo apt-get update -y

#npm
npm install

npm start &





