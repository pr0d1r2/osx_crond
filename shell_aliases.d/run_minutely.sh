function run_minutely() {
  if [ ! -d $HOME/.cron.d/minutely ]; then
    echo "No $HOME/.cron.d/minutely you need to setup osx_crond first ..."
    return 1001
  fi
  run_periodically_commons > $HOME/.cron.d/minutely/$1.sh
  echo "$@" >> $HOME/.cron.d/minutely/$1.sh
}
