#!/bin/bash
log_name='access.log'
base_path='/home/rgc/baidu_eye/logs/'
log_path=$(date -d yesterday +"%Y-%m-%d;%H:%M:%S").log
echo move $base_path$log_path success!
mv $base_path$log_name $base_path$log_path
kill -USR1 `cat /run/nginx.pid`
