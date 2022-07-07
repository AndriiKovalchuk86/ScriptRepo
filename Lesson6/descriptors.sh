#!/bin/bash

lsof -u andriy | tr -s ' ' | cut -d ' ' -f 2,4,9 > descriptors.txt

