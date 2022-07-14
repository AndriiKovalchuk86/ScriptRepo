#!/bin/bash

name=$(ps -A | grep apache2 | head -1 | awk '{print $4}')
pid=$(ps -A | grep apache2 | head -1 | awk '{print $1}')

if [ -z $pid ]
                   then
                       echo "Process not found"    
                   else
                        sudo systemctl stop $name
                        echo "Process $name $pid stopped"
fi

sleep 10
#sudo systemctl start apache2.service
status=$(systemctl is-active apache2.service)
if [ "$status" = "active" ] 
                           then
                               pid=$(ps -A | grep apache2 | head -1 | awk '{print $1}')
                               sudo kill -9 $pid
                               echo "Process $name $pid stopped"
                            else
                                echo "Daemon is inactive, nothing to do"
fi
