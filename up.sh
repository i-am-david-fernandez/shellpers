## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## A helper function to allow quick and convenient traversal up through the directory tree.
## Use 'up' to navigate to parent (first ancestor) directory, 'up N' to navigate to N'th ancestor.
## Using the option '-q' will simply query and print the resultant directory without
## changing to it.
up ()
{
    height=1;

    for arg in $*
    do
        case "$arg" in
            "-q")
                shift
                d=`up $*; pwd`
                echo $d
                return
            ;;
            *)
                height=$arg
                ;;
        esac
        shift
    done

    for i in `seq $height`
    do
        cd ..
    done
}
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
