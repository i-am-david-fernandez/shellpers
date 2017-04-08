## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
##
## Symbolic definitions of a bunch of useful terminal colour escape codes.
##
## For reference material see e.g. http://misc.flogisoft.com/bash/tip_colors_and_formatting

get_colour_code()
{
    code="\033["
    for spec in $*
    do
        case "$spec" in
            "default")
                code="${code}39m"
                ;;

            "reset")
                code="${code}00m"
                ;;

            "bold")
                code="${code}1;"
                ;;
            "dim")
                code="${code}2;"
                ;;
            "underlined")
                code="${code}4;"
                ;;
            "blink")
                code="${code}5;"
                ;;
            "inverse")
                code="${code}7;"
                ;;

            "black")
                code="${code}30m"
                ;;
            "red")
                code="${code}31m"
                ;;
            "green")
                code="${code}32m"
                ;;
            "yellow")
                code="${code}33m"
                ;;
            "blue")
                code="${code}34m"
                ;;
            "magenta")
                code="${code}35m"
                ;;
            "cyan")
                code="${code}36m"
                ;;
            "grey")
                code="${code}37m"
                ;;

            "light_black")
                code="${code}90m"
                ;;
            "light_red")
                code="${code}91m"
                ;;
            "light_green")
                code="${code}92m"
                ;;
            "light_yellow")
                code="${code}93m"
                ;;
            "light_blue")
                code="${code}94m"
                ;;
            "light_magenta")
                code="${code}95m"
                ;;
            "light_cyan")
                code="${code}96m"
                ;;
            "light_grey")
                code="${code}97m"
                ;;

        esac
    done

    echo ${code}
}

generate_colour_variables()
{
    echo colour_default='"'`get_colour_code default`'"'
    echo colour_reset='"'`get_colour_code reset`'"'

    colours="black red green yellow blue magenta cyan grey"
    modifiers="plain bold dim underlined blink inverse"
    for colour in $colours
    do
        for modifier in $modifiers
        do
            echo colour_${modifier}_${colour}='"'`get_colour_code $modifier $colour`'"'
            echo colour_${modifier}_light_${colour}='"'`get_colour_code $modifier light_$colour`'"'
        done
    done
}

demo_colours()
{
    colours="black red green yellow blue magenta cyan grey"
    modifiers="plain bold dim underlined blink inverse"
    echo "---"
    for colour in $colours
    do
        for modifier in $modifiers
        do
            code="colour_${modifier}_${colour}"
            echo -en ${!code}${modifier}-${colour}${colour_reset}
            echo -en "\t\t"
            code="colour_${modifier}_light_${colour}"
            echo -e ${!code}${modifier}_light_${colour}${colour_reset}

        done
    done
    echo "---"
}


if [ "$0" != "-bash" ]
then
    generate_colour_variables > colour_definitions.sh
    source colour_definitions.sh
    demo_colours
fi
##
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
