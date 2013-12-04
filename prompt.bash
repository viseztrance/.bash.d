declare red="\[\e[31m\]"
declare green="\[\e[92m\]"
declare yellow="\[\e[93m\]"
declare blue="\[\e[94m\]"
declare cyan="\[\e[96m\]"
declare wipe="\[\033[1m\033[0m\]"

__is_git_repo() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

__is_dirty_repo() {
    [ $(git diff --shortstat | wc -l) != "0" ]
}

__get_git_branch() {
    git symbolic-ref --short HEAD
}

__get_git_root() {
    git rev-parse --show-toplevel
}

__is_ruby_project() {
    [ -f "$(__get_git_root)/Gemfile" ]
}

__get_ruby_version() {
    ruby --version | grep -Po '^\w+\s+\K.*?(?=\s+)'
}

__get_git_info() {
    local status="✓"
    if __is_dirty_repo; then
        status="✗"
    fi
    echo -n "${blue}git:(${wipe}${red}$(__get_git_branch)${wipe}${blue})${wipe} ${yellow}$status${wipe} "
}

__get_ruby_info() {
    echo -n "${red}⚡${wipe} ${blue}ruby:(${wipe}${red}$(__get_ruby_version)${wipe}${blue})${wipe} ${red}⚡${wipe} "
}

__get_development_prompt() {
    if __is_git_repo; then
        if __is_ruby_project; then
            __get_ruby_info
        fi
        __get_git_info
    fi
}

set_prompt() {
    PS1="${red}➜${wipe} ${cyan}\W${wipe} $(__get_development_prompt)"
}

PROMPT_COMMAND=set_prompt
