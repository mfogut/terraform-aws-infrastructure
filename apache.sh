#!/bin/bash

yum update -y
yum install httpd -y

systemctl start httpd
systemctl enable httpd

echo "<h1> Deployed via Terraform By Fatih  </h1>" > /usr/share/nginx/html/index1.html

cd /usr/share/nginx/html/
cp index1.html index.html
rm -rf index1.html
