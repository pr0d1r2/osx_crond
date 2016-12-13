function run_hourly() {
  if [ ! -d $HOME/.cron.d/hourly ]; then
    echo "No $HOME/.cron.d/hourly you need to setup osx_crond first ..."
    return 1001
  fi
  echo "#!`which zsh`" > $HOME/.cron.d/hourly/$1.sh
  echo "source $HOME/.compiled_shell_aliases.sh" >> $HOME/.cron.d/hourly/$1.sh
  echo "$@" >> $HOME/.cron.d/hourly/$1.sh
}
