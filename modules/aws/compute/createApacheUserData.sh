#!/bin/bash

#Installoing Apache Web Server
sudo su
yum install httpd -y

#Getting AZ
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`

#Configuring index.html
echo "<p>This Web server is in $EC2_AVAIL_ZONE </p>" >> /var/www/html/index.html

#Enable and starting Apache service
sudo systemctl enable httpd
sudo systemctl start httpd