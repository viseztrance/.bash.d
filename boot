for file in $HOME/.bash.d/scripts/*.bash; do
    source $file
done

unset file
