#!/bin/bash

name=$(ps -A | grep apache2 | head -1 | awk '{print $4}')
pid=$(ps -A | grep apache2 | head -1 | awk '{print $1}')
i=0

if [ -z $pid ]
                   then
                       echo "Process not found"    
                   else
                        sudo kill -SIGTSTP $pid
                        while [ $i -le 6 ]
                        do
                          echo "Process $name $pid suspended"
                          sleep 5
                          ((i++))
                        done
fi


