#!/bin/sh

mv ./site/* /var/www/portfolio/
nginx -g 'daemon off;'
