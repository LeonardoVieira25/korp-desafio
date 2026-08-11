#!/bin/bash

mkdir -p ./keys
ssh-keygen -t rsa -b 4096 -f ./keys/.hetzner.key -N "" -C "korp-hetzner"