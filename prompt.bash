declare red="\e[31m"
declare yellow="\e[93m"
declare blue="\e[94m"
declare cyan="\e[96m"
declare wipe="\033[1m\033[0m"

is_git_repo() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

is_dirty_repo() {
    [ $(git diff --shortstat | wc -l) != "0" ]
}

get_git_branch() {
    git symbolic-ref --short HEAD
}

get_version_control() {
    local status="✓"

    if is_git_repo; then
        if is_dirty_repo; then
            status="✗"
        fi
        echo -e "${blue}git:(${wipe}${red}$(get_git_branch)${wipe}${blue})${wipe} ${yellow}$status${wipe} "
    fi
}

PS1="${red}➜${wipe} ${cyan}\W${wipe} \$(get_version_control)"
