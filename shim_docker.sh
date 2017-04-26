## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## Docker client command shim
## This shims the command 'docker' to inject some useful options.
## For example,this will inject an alternative default output format for
## the 'ps' sub-command.

docker()
{
    local docker_bin=`which docker`
    local args=()

    for arg in $*
    do
        case "$arg" in
            "ps")
                local ps_format="table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.CreatedAt}}\t{{.Ports}}"
                args+=($arg "--format" $ps_format)
                ;;
            *)
                args+=($arg)
                ;;
        esac
        shift
    done

    #echo $docker_bin ${args[@]}
    $docker_bin ${args[@]}
}
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘

