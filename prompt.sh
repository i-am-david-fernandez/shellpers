## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Stolen and slightly modified from https://kura.io/2013/08/18/my-ps1-with-git-branch-new-files-staged-files-and-commit-status/
## The messy-looking flipping between single and double quotes is necessary to ensure control codes and function evaluation
## happen correctly.
## Use of '\[','\]' pairings as per https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history

## Requires colour_definitions.sh
##source colour_definitions.sh

SYMBOL_RCS="@"

if [ `id -u` == 0 ]; then
    ## More prominant colouring for root
    USER_COLOUR=$colour_blink_red
    PATH_COLOUR=$colour_bold_blue
else
    USER_COLOUR=$colour_plain_green
    PATH_COLOUR=$colour_bold_blue
fi

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
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

rcs_unadded_new()
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

rcs_needs_commit()
{
    if [[ "git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && git rev-parse --quiet --verify HEAD &> /dev/null
    then
        git diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
        (( $? && $? != 128 )) && echo "$SYMBOL_RCS"
    fi
}

rcs_modified_files()
{
    if [[ "git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && git rev-parse --quiet --verify HEAD &> /dev/null
    then
        git diff --no-ext-diff --ignore-submodules --quiet --exit-code || echo "$SYMBOL_RCS"
    fi
}

rcs_prompt()
{
    echo -n "\[$colour_bold_magenta\]"'$(rcs_branch)'"\[${colour_reset}\]"
    echo -n "\[$colour_plain_green\]"'$(rcs_needs_commit)'"\[${colour_reset}\]"
    echo -n "\[$colour_plain_yellow\]"'$(rcs_modified_files)'"\[${colour_reset}\]"
    echo -n "\[$colour_plain_red\]"'$(rcs_unadded_new)'"\[${colour_reset}\]"
}

PS1="$(user_prompt):$(path_prompt) $(rcs_prompt) $ "
#PS1="$(user_prompt):$(path_prompt) $ "

## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
