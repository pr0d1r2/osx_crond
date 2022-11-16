function run_at() {
  local run_at_HOUR
  case $1 in
    [0-9]:[0-9][0-9])
      run_at_HOUR="0$1"
      ;;
    [0-9][0-9]:[0-9][0-9])
      run_at_HOUR="$1"
      ;;
    *)
      return 101
      ;;
  esac

  if [ ! -d $HOME/.cron.d/at ]; then
    echo "No $HOME/.cron.d/at you need to setup osx_crond first ..."
    return 1001
  fi
  test -d "$HOME/.cron.d/at/$run_at_HOUR" || mkdir "$HOME/.cron.d/at/$run_at_HOUR"

  local run_at_FILENAME
  run_at_FILENAME="$(echo "${@:2}" | shasum | cut -f 1 -d " ")"

  run_periodically_commons > "$HOME/.cron.d/at/$run_at_HOUR/$run_at_FILENAME.sh"
  echo "${@:2}" >> "$HOME/.cron.d/at/$run_at_HOUR/$run_at_FILENAME.sh"
}
