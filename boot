PATH=$PATH:~/.bash.d/bin

for file in $HOME/.bash.d/scripts/*.bash; do
    source $file
done

if [ -d $HOME/.bash.custom ]; then
    for file in $HOME/.bash.custom/*.bash; do
        source $file
    done
fi

unset file
