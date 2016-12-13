#!/bin/sh

for SCRIPT in `find ROOT_DIR -type f -name "*.sh"`
do
  ZSH_LOCATION $SCRIPT
done
