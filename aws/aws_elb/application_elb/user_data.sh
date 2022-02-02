#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
