#!/usr/bin/env bash

systemctl enable httpd.service
systemctl start httpd.service

echo $(hostname) >> /var/www/html/index.html