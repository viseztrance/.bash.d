alias reload!="source ~/.bashrc && echo \"Bash config reloaded!\""

alias be="bundle exec"
alias r="bundle exec rspec"
alias ram="ps aux | awk '{print \$6/1024 \" MB\t\t\" \$11}'  | sort -n"

if which exa &> /dev/null; then
  alias ls="exa"
fi
