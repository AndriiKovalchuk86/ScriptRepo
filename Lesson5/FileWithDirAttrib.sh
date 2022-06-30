#!/bin/bash 

for file in /etc/*
do
if [ -d "$file" ] 
then
echo $file >> etc_dir.txt
fi
done
