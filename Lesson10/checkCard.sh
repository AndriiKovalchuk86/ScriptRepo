#!/bin/bash

awk '/^[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] [0-9][0-9]\/[0-9][0-9]$/{print$0}' Card.txt
