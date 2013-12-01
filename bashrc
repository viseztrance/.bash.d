for file in $HOME/.bash.d/*.bash
do
    source $file
done

unset file
