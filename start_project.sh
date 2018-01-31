#!/bin/bash
uwsgi --ini baidu_eye.ini
#uwsgi --ini baidu_eye.ini --daemonize /home/rgc/baidu_eye/carrier.log
echo 'start uwsgi success!'