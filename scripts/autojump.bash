if [ -f /usr/share/autojump/autojump.bash ]; then
    source /usr/share/autojump/autojump.bash
fi

j () {
    if ! [ -x "$(command -v autojump)" ]; then
        printf "\\033[31mautojump is not installed\\033[0m\n"
        return
    fi

    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@};
        return;
    fi;
    output="$(autojump ${@})";
    if [[ -d "${output}" ]]; then
        if [ -t 1 ]; then
            printf "\\033[38;05;210m⇒\\033[0m \\033[92m${output}\\033[0m\n";
        else
            printf "${output}\n";
        fi;
        cd "${output}";
    else
        echo "autojump: directory '${@}' not found";
        echo "\n${output}\n";
        echo "Try \`autojump --help\` for more information.";
        false;
    fi
}
