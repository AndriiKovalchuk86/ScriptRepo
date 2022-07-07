#!/bin/bash

find /usr/sbin -type f -perm -+r+x  >> usr_executables.txt
