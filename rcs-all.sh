## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Perform an rcs (git, svn etc.) operation on a set of recursively-found rcs repositories,
## e.g., perform 'rcs status' on all rcs repositories under the current directory.

rcs_all()
{
    local rcs=$1
    shift

    if [ -d $1 ]
    then
        local base_dir=$1
        shift
    else
        local base_dir=`realpath ./`
    fi

    if [ ! "$*" ]
    then
        echoError "Error! No options specified."
        echoInfoMinor \
            "Usage:
  $0 [base directory] <rcs operation>
  e.g.: $0 ./my-projects status
  to perform '<rcs> status' on all <rcs> repos found under the directory './my-projects'
  If unspecified, the current directory will be used as a base.
"
        return
    fi

    for rcs_dir in `find $base_dir -type d -name ".${rcs}" | sort`
    do
        rcs_dir=`realpath "$rcs_dir/.."`
        echoInfoMajor "Operating in $rcs_dir"
        pushd $rcs_dir > /dev/null
        $rcs $*
        popd > /dev/null
    done
}

alias git-all='rcs_all git'
alias svn-all='rcs_all svn'
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
