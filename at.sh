#!/bin/sh

HOURS_AND_MINUTES="$(date "+%H:%M")"

if [ -d "ROOT_DIR/$HOURS_AND_MINUTES" ]; then
  for SCRIPT in $(find "ROOT_DIR/$HOURS_AND_MINUTES" -type f -name "*.sh")
  do
    ZSH_LOCATION $SCRIPT &> $SCRIPT.log
  done
fi
