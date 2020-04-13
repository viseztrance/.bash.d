alias reload!="source ~/.bashrc && echo \"Bash config reloaded!\""

alias be="bundle exec"
alias r="bundle exec rspec"

if which exa &> /dev/null; then
  alias ls="exa"
fi
