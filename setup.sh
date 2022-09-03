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

test -d "$HOME/Library/LaunchAgents" || mkdir -p "$HOME/Library/LaunchAgents" || exit $?

for PERIOD in minutely hourly daily
do
  SCRIPT_PATH="$BASE_DIR/$PERIOD.sh"
  INTERVAL=`interval_for_period $PERIOD`
  ROOT_DIR="$BASE_DIR/$PERIOD"
  ZSH_LOCATION=`which zsh`

  if [ ! -d $ROOT_DIR ]; then
    mkdir -p $ROOT_DIR || exit $?
  fi

  cat $D_R/period.sh | \
    sed -e "s|ROOT_DIR|$ROOT_DIR|g" \
        -e "s|ZSH_LOCATION|$ZSH_LOCATION|g" \
    > $BASE_DIR/$PERIOD.sh || exit $?

  chmod +x "$BASE_DIR/$PERIOD.sh"

  cat $D_R/period.plist | \
    sed -e "s|PERIOD_NAME|$PERIOD|g" \
        -e "s|SCRIPT_PATH|$SCRIPT_PATH|g" \
        -e "s|INTERVAL|$INTERVAL|g" \
    > $HOME/Library/LaunchAgents/com.example.osx.crond.$PERIOD.plist || exit $?

  launchctl unload -w $HOME/Library/LaunchAgents/com.example.osx.crond.$PERIOD.plist
  launchctl load -w $HOME/Library/LaunchAgents/com.example.osx.crond.$PERIOD.plist
done

for AT_TYPE in at at_weekdays
do
  ROOT_DIR="$BASE_DIR/$AT_TYPE"
  test -d "$ROOT_DIR" || mkdir -p "$ROOT_DIR"
  cat "$D_R/$AT_TYPE.sh" | \
    sed -e "s|ROOT_DIR|$ROOT_DIR|g" \
        -e "s|ZSH_LOCATION|$ZSH_LOCATION|g" \
    > "$BASE_DIR/minutely/${AT_TYPE}_poll.sh" || exit $?

  chmod +x "$BASE_DIR/minutely/${AT_TYPE}_poll.sh"
done
