function run_periodically_commons() {
  echo "#!`which zsh`"
  if [ -d $HOME/.rbenv/bin ]; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"'
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi'
  fi
  echo "source $HOME/.compiled_shell_aliases.sh"
}
