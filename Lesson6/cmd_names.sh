#!/bin/bash

fileCount=$(wc -l usr_executables.txt | cut -d ' ' -f1)
echo "File count $fileCount"

head usr_executables.txt | cut -d "/" -f4 > cmd_names.txt
