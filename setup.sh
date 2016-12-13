#!/bin/sh

D_R=`cd \`dirname $0\` ; pwd -P`

BASE_DIR="$HOME/.cron.d"

function interval_for_period() {
  case $1 in
    minutely)
      echo 60
      ;;
    hourly)
      echo 3600
      ;;
    daily)
      echo 86400
      ;;
  esac
}

for PERIOD in minutely hourly daily
do
  SCRIPT_PATH="$BASE_DIR/$PERIOD.sh"
  INTERVAL=`interval_for_period $PERIOD`
  ROOT_DIR="$BASE_DIR/$PERIOD"

  if [ ! -d $ROOT_DIR ]; then
    mkdir -p $ROOT_DIR || exit $?
  fi

  cat $D_R/period.sh | \
    sed -e "s|ROOT_DIR|$ROOT_DIR|g" \
    > $BASE_DIR/$PERIOD.sh || exit $?

  cat $D_R/period.plist | \
    sed -e "s|PERIOD_NAME|$PERIOD|g" | \
    sed -e "s|SCRIPT_PATH|$SCRIPT_PATH|g" | \
    sed -e "s|INTERVAL|$INTERVAL|g" \
    > $HOME/Library/LaunchAgents/com.example.osx.crond.$PERIOD.plist || exit $?

  launchctl load -w $HOME/Library/LaunchAgents/com.example.osx.crond.$PERIOD.plist
done
