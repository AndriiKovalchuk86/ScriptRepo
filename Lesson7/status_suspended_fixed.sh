#!/bin/bash

name=$(ps -A | grep apache2 | head -1 | awk '{print $4}')
pid=$(ps -A | grep apache2 | head -1 | awk '{print $1}')
i=0

while [ $i -le 6 ]
                  do
                    if [ -z $pid ]
                                  then
                                  echo "Process not found"    
                    else
                    sudo kill -SIGTSTP $pid
                    echo "Process $name $pid suspended"
                    fi
sleep 5
((i++))
done
