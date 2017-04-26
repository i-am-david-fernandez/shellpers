## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Subversion client command shim
## This shims the command 'svn' to inject some useful options.
## The following command will produce a list of canonical svn subcommands,
## which may be of help when extending this thing.
##  svn help | awk "/$mark_start/{flag=1;next}/$mark_end/{flag=0}flag" | awk '{print $1}'

svn()
{
    local svn_bin=`which svn`
    local svn_colour_bin=`which svn-colour.py`

    # local args=()
    # for arg in $*
    # do
    #     case "$arg" in
    #         *)
    #             args+=($arg)
    #             ;;
    #     esac
    #     shift
    # done
    # #echo $svn_bin ${args[@]}
    # $svn_bin ${args[@]}

    case "$1" in
        "diff")
            #$svn_colour_bin $* | less -rFX
            shift
            $svn_bin diff --diff-cmd colordiff $* | less -rFX
            return
            ;;

        "id")
            shift
            $svn_bin propset svn:keywords Id $*
            ;;
        "ignore")
            shift
            $svn_bin propedit svn:ignore $*
            ;;
        "rev")
            shift
            $svn_bin propset svn:keywords Revision $*
            ;;
        "branch-source")
            shift
            $svn_bin log -v -r0:HEAD --stop-on-copy --limit 1 $*
            ;;

        "untracked")
            echo "Untracked files:"
            echo -en ${colour_plain_blue}
            $svn_bin status | grep "^?" | sed "s/^?\s*\(.*\)/\1/"
            echo -en ${colour_reset}
            ;;
        "modified")
            echo "Modified files:"
            echo -en ${colour_plain_yellow}
            $svn_bin status | grep "^M" | sed "s/^M\s*\(.*\)/\1/"
            echo -en ${colour_reset}
            ;;
        "deleted")
            echo "Deleted files:"
            echo -en ${colour_plain_red}
            $svn_bin status | grep "^!" | sed "s/^!\s*\(.*\)/\1/"
            echo -en ${colour_reset}
            ;;

        "--")
            shift
            $svn_colour_bin $*
            ;;

        *)
            $svn_colour_bin $*
            ;;

    esac
}
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘

