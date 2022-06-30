#!/bin/bash 

for file in /usr/bin/*
do
if [ -f "$file" ] 
then
    if [ -x "$file" ]
    then
    echo "Executable file $file" >> ExecutableFiles.txt
    fi
fi
done
