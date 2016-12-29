function run_hourly() {
  if [ ! -d $HOME/.cron.d/hourly ]; then
    echo "No $HOME/.cron.d/hourly you need to setup osx_crond first ..."
    return 1001
  fi
  run_periodically_commons > $HOME/.cron.d/hourly/$1.sh
  echo "$@" >> $HOME/.cron.d/hourly/$1.sh
}
