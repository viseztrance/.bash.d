declare red="\[\e[38;05;210m\]"
declare green="\[\e[92m\]"
declare yellow="\[\e[93m\]"
declare blue="\[\e[94m\]"
declare cyan="\[\e[96m\]"
declare wipe="\[\033[1m\033[0m\]"

__truncate_path() {
    local path=$1
    local max=$2
    local length=${#path}
    if (( length > max )); then
        echo "…${path:((length - max))}"
    else
        echo $path
    fi
}

__is_git_repo() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

__is_dirty_repo() {
    [ $(git status --porcelain --untracked-files=no | wc -l) != "0" ]
}

__get_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null
}

__get_git_root() {
    git rev-parse --show-toplevel
}

__get_git_relative_path() {
    git rev-parse --show-prefix
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
    echo -n "${red}✵${wipe} ${blue}ruby:(${wipe}${red}$(__get_ruby_version)${wipe}${blue})${wipe} ${red}✵${wipe} "
}

__get_development_prompt() {
    if __is_git_repo; then
        if __is_ruby_project; then
            if [ "$SHOW_RUBY_VERSION" = true ]; then
                __get_ruby_info
            fi
        fi
        __get_git_info
    fi
}

__get_working_directory() {
    local prefix
    local path
    local max=$(printf %.$2f $(bc <<< "$(tput cols) * 0.5"))
    if __is_git_repo; then
        prefix="⤷"
        path=$(basename "$(__get_git_root)")/$(__get_git_relative_path)
    else
        prefix="➜"
        path=${PWD/#$HOME/\~}
    fi
    if ((${#path} > max)); then
        path=$(__truncate_path $path $max)
    fi
    echo -n "${red}$prefix${wipe} ${cyan}${path%/}${wipe}"
}

set_prompt() {
    PS1="$(__get_working_directory) $(__get_development_prompt)"
}

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;set_prompt}"
