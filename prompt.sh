## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Stolen and slightly modified from https://kura.io/2013/08/18/my-ps1-with-git-branch-new-files-staged-files-and-commit-status/
## The messy-looking flipping between single and double quotes is necessary to ensure control codes and function evaluation
## happen correctly.
## Use of '\[','\]' pairings as per https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history

## Requires colour_definitions.sh
##source colour_definitions.sh

if [ `id -u` == 0 ]; then
    ## More prominant colouring for root
    USER_COLOUR=$colour_blink_red
    PATH_COLOUR=$colour_bold_blue
else
    USER_COLOUR=$colour_plain_green
    PATH_COLOUR=$colour_bold_blue
fi

bin_svn=`which svn 2> /dev/null`
bin_git=`which git 2> /dev/null`

user_prompt()
{
    echo -n '${debian_chroot:+($debian_chroot)}'"\[$USER_COLOUR\]"'\u@\h'"\[${colour_reset}\]"
}

short_pwd()
{
    echo $PWD | sed "s:${HOME}:~:" | sed "s:/\(.\{1\}\)[^/]*:/\1:g" | sed "s:/[^/]*$:/$(basename $PWD):"
}

path_prompt()
{
    echo -n "\[$PATH_COLOUR\]"'$(short_pwd)'"\[${colour_reset}\]"
}

rcs_branch()
{
    if inside_git
    then
        $bin_git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    fi
}

rcs_untracked()
{
    if inside_git
    then
        $bin_git status --porcelain | grep "\s*?" > /dev/null && rcs_symbol
        # if [[ -z $($bin_git ls-files --other --exclude-standard 2> /dev/null) ]]
        # then
        #     echo ""
        # else
        #     rcs_symbol
        # fi
    elif inside_svn
    then
        $bin_svn status | grep "^?" > /dev/null && rcs_symbol
    fi
}

rcs_modified()
{
    if inside_git
    then
        $bin_git status --porcelain | grep "\s*M" > /dev/null && rcs_symbol
        #$bin_git diff --no-ext-diff --ignore-submodules --quiet --exit-code || rcs_symbol
    elif inside_svn
    then
        $bin_svn status | grep "^M" > /dev/null && rcs_symbol
    fi
}

rcs_deleted()
{
    if inside_git
    then
        $bin_git status --porcelain | grep "\s*D" > /dev/null && rcs_symbol
        # if [[ -z $($bin_git ls-files --deleted --exclude-standard 2> /dev/null) ]]
        # then
        #     echo ""
        # else
        #     rcs_symbol
        # fi
        # if [[ $files_deleted ]]
        # then
        #     rcs_symbol
        # fi
    elif inside_svn
    then
        $bin_svn status | grep "^\!" > /dev/null && rcs_symbol
    fi
}

rcs_needs_commit()
{
    if inside_git
    then
        $bin_git diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
        (( $? && $? != 128 )) && rcs_symbol
    fi
}

status_git()
{
    files_modified=0
    files_deleted=0
    files_untracked=0

    $bin_git status --porcelain | awk '{print $1}' | sort | uniq | while read -r line
    do
        case $line in
            "??")
                files_untracked=1
            ;;
            "D")
                files_deleted=1
            ;;
            "M")
                files_modified=1
            ;;
        esac
    done
}

inside_git()
{
    if [[ -n "$bin_git" ]]
    then
        #if [[ "$bin_git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && $bin_git rev-parse --quiet --verify HEAD &> /dev/null
        if $bin_git rev-parse --is-inside-work-tree &> /dev/null
        then
            return 0
        fi
    fi

    return 1
}

inside_svn()
{
    if [[ -n "$bin_svn" ]]
    then
        if $bin_svn info &> /dev/null
        then
            return 0
        fi
    fi

    return 1
}

rcs_symbol()
{
    local symbol=""
    if inside_git
    then
        symbol="G"
    fi

    if inside_svn
    then
        symbol="S"
    fi

    echo -n "$symbol"
}

rcs_which()
{
    local type=""
    if inside_git
    then
        type="git"
        #status_git
    elif inside_svn
    then
        type="svn"
    fi

    echo "$type"
}

rcs_prompt()
{
    echo -n "\[$colour_dim_grey\]"'$(rcs_which)'"\[${colour_reset}\]"

    echo -n "\[$colour_bold_magenta\]"'$(rcs_branch)'"\[${colour_reset}\]"
    echo -n "\[$colour_blink_green\]"'$(rcs_needs_commit)'"\[${colour_reset}\]"
    echo -n "\[$colour_plain_cyan\]"'$(rcs_untracked)'"\[${colour_reset}\]"
    echo -n "\[$colour_plain_yellow\]"'$(rcs_modified)'"\[${colour_reset}\]"
    echo -n "\[$colour_blink_red\]"'$(rcs_deleted)'"\[${colour_reset}\]"
}

PS1="$(user_prompt):$(path_prompt) $(rcs_prompt) $ "
#PS1="$(user_prompt):$(path_prompt) $ "

## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
