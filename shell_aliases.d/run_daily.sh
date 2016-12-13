function run_daily() {
  if [ ! -d $HOME/.cron.d/daily ]; then
    echo "No $HOME/.cron.d/daily you need to setup osx_crond first ..."
    return 1001
  fi
  echo "#!`which zsh`" > $HOME/.cron.d/daily/$1.sh
  echo "source $HOME/.compiled_shell_aliases.sh" >> $HOME/.cron.d/daily/$1.sh
  echo "$@" >> $HOME/.cron.d/daily/$1.sh
}
