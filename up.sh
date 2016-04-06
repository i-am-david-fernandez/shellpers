## <DF> A helper function to allow quick and convenient traversal up through the directory tree.
## Use 'up' to navigate to parent (first ancestor) directory, 'up N' to navigate to N'th ancestor.
up ()
{
    height=1;
    if [ $1 ]
    then
        height=$1;
    fi

    for i in `seq $height`
    do
        cd ..
    done
}
