#!/bin/bash

name=$(ps -A | grep apache2 | head -1 | awk '{print $4}')
pid=$(ps -A | grep apache2 | head -1 | awk '{print $1}')

if [[ $pid -gt 0 ]]
                   then
                        sudo kill -15 $pid
                        echo "Process $name $pid stopped"
fi

