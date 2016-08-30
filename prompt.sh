## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Stolen and slightly modified from https://kura.io/2013/08/18/my-ps1-with-git-branch-new-files-staged-files-and-commit-status/
## The messy-looking flipping between single and double quotes is necessary to ensure control codes and function evaluation
## happen correctly.

COLOUR_RED="31m"
COLOUR_YELLOW="33m"
COLOUR_GREEN="32m"

COLOUR_BOLD_RED="01;31m"
COLOUR_BOLD_GREEN="01;32m"
COLOUR_BOLD_BLUE="01;34m"
COLOUR_BOLD_MAGENTA="01;35m"

SYMBOL_RCS="@"

ANSI_ESCAPE="\[\033"
ANSI_RESET="${ANSI_ESCAPE}[00m\]"

if [ `id -u` = 0 ]; then
    USER_COLOUR="04;$COLOUR_BOLD_RED"
    PATH_COLOUR=$COLOUR_BOLD_RED
else
    USER_COLOUR=$COLOUR_BOLD_GREEN
    PATH_COLOUR=$COLOUR_BOLD_BLUE
fi

function user_prompt
{
    echo -n '${debian_chroot:+($debian_chroot)}'"${ANSI_ESCAPE}[$USER_COLOUR\]"'\u@\h'"${ANSI_RESET}"
}

function short_pwd
{
    echo $PWD | sed "s:${HOME}:~:" | sed "s:/\(.\{1\}\)[^/]*:/\1:g" | sed "s:/[^/]*$:/$(basename $PWD):"
}

function path_prompt
{
    echo -n "${ANSI_ESCAPE}[$PATH_COLOUR\]"'$(short_pwd)'"${ANSI_RESET}"
}

function rcs_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function rcs_unadded_new
{
    if git rev-parse --is-inside-work-tree &> /dev/null
    then
        if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]
        then
            echo ""
        else
            echo "$SYMBOL_RCS"
        fi
    fi
}

function rcs_needs_commit
{
    if [[ "git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && git rev-parse --quiet --verify HEAD &> /dev/null
    then
        git diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
        (( $? && $? != 128 )) && echo "$SYMBOL_RCS"
    fi
}

function rcs_modified_files
{
    if [[ "git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && git rev-parse --quiet --verify HEAD &> /dev/null
    then
        git diff --no-ext-diff --ignore-submodules --quiet --exit-code || echo "$SYMBOL_RCS"
    fi
}

function rcs_prompt
{
    echo -n "${ANSI_ESCAPE}[$COLOUR_BOLD_MAGENTA\]"'$(rcs_branch)'"${ANSI_RESET}"
    echo -n "${ANSI_ESCAPE}[$COLOUR_GREEN\]"'$(rcs_needs_commit)'"${ANSI_RESET}"
    echo -n "${ANSI_ESCAPE}[$COLOUR_YELLOW\]"'$(rcs_modified_files)'"${ANSI_RESET}"
    echo -n "${ANSI_ESCAPE}[$COLOUR_RED\]"'$(rcs_unadded_new)'"${ANSI_RESET}"
}

PS1="$(user_prompt):$(path_prompt) $(rcs_prompt) $ "

## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
