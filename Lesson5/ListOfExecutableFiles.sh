#!/bin/bash 

for file in /usr/bin/*
do
if [ -f "$file" ] 
then
    if [ -x "$file" ]
    then
    echo "Executable file $file" >> executable.txt
    fi
fi
done
