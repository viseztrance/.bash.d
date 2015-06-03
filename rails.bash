boot-rails() {
    if which guake > /dev/null; then
        local path=$(pwd)
        if [ -f "${PWD}/Gemfile" ]; then
            guake -e "cd . && reset"
            guake -e "bundle exec rails s || notify-send -u critical \"Rails couldn't be started\""
            guake -r "server"
            guake -n $path
            guake -r "console"
            guake -e "cd . && reset"
            guake -e "bundle exec rails c"
            guake -n $path
            guake -e "cd . && reset"
            guake -r "test"
        else
            notify-send -u critical "This doesn't appear to be a rails project"
        fi
    else
        notify-send -u critical "Guake is not installed"
    fi
}
