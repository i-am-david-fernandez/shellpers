#!/bin/bash


## <DF> Perform a git operation on a set of recursively-found git repositories,
## e.g., perform 'git status' on all git repositories under the current directory.

gitAll()
{
    if [ -d $1 ]
    then
        base_dir=$1
        shift
    else
        base_dir=`realpath ./`
    fi

    if [ ! "$*" ]
    then
        echoError "Error! No options specified."
        echoInfoMinor \
            "Usage:
  $0 [base directory] <git operation>
  e.g.: $0 ./my-projects status
  to perform 'git status' on all git repos found under the directory './my-projects'
  If unspecified, the current directory will be used as a base.
"
        exit 1
    fi

    for git_dir in `find $base_dir -type d -name ".git" | sort`
    do
        git_dir=`realpath "$git_dir/.."`
        echoInfoMajor "Operating in $git_dir"
        git -C $git_dir $*
    done
}
