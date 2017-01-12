function crond_update_scripts() {
  local crond_update_scripts_PERIOD
  local crond_update_scripts_SCRIPT
  local crond_update_scripts_COMMAND_FROM_FILENAME
  local crond_update_scripts_COMMAND_FROM_LAST_LINE
  for crond_update_scripts_PERIOD in daily hourly minutely
  do
    for crond_update_scripts_SCRIPT in `find $HOME/.cron.d/$crond_update_scripts_PERIOD -type f -name "*.sh"`
    do
      crond_update_scripts_COMMAND_FROM_FILENAME=`basename $crond_update_scripts_SCRIPT | sed -e 's/.sh$//'`
      crond_update_scripts_COMMAND_FROM_LAST_LINE=`tail -1 $crond_update_scripts_SCRIPT`
      case $crond_update_scripts_COMMAND_FROM_FILENAME in
        $crond_update_scripts_COMMAND_FROM_LAST_LINE)
          echorun run_$crond_update_scripts_PERIOD $crond_update_scripts_COMMAND_FROM_FILENAME || return $?
          ;;
      esac
    done
  done
}
