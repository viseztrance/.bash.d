confirm () {
    while true; do
        read -p "$1 " yn
        case ${yn:-$2} in
            [Yy]* ) return 0;;
            [Nn]* ) echo 'Aborted' && return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

export -f confirm
