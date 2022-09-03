function run_at_weekdays() {
  if [ ! -d $HOME/.cron.d/at ]; then
    echo "No $HOME/.cron.d/at you need to setup osx_crond first ..."
    return 1001
  fi
  test -d "$HOME/.cron.d/at_weekdays/$1" || mkdir "$HOME/.cron.d/at_weekdays/$1"

  local run_at_weekdays_FILENAME
  run_at_weekdays_FILENAME="$(echo "${@:2}" | shasum | cut -f 1 -d " ")"

  run_periodically_commons > "$HOME/.cron.d/at_weekdays/$1/$run_at_weekdays_FILENAME.sh"
  echo "${@:2}" >> "$HOME/.cron.d/at_weekdays/$1/$run_at_weekdays_FILENAME.sh"
}
