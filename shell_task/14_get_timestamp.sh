#!/usr/bin/env bash

# https://stackoverflow.com/questions/17066250/create-timestamp-variable-in-bash-script

timestamp=$(date +%s)
echo ${timestamp}

timestamp=$(date +%T)
echo ${timestamp}

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
echo ${timestamp}
