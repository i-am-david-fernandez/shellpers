## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## These 'echo' wrappers provide a convenient way to produce coloured terminal messages from scripts using
## simple escape codes. They are intended for use in terminals with a dark-background theme (e.g., white text
## on black background).

## The names suggest their intended use:
##   - info_major produces bright green text for (good) important information,
##   - info_minor produces comparatively dull blue text for (good) information of secondary importance,
##   - warning produces comparatively dull yellow text for (bad) information of secondary importance,
##   - error produces bright red text for (bad) critically-important information.

## Usage:
##  echo_xyz "This is a coloured message!"
## e.g.,
##    echo_info_major "Performing first stage processing of large dataset..."
##    echo_info_minor "  - Doing the first thing..."
##    echo_info_minor "  - Reticulating splines..."
##    echo_info_major "Complete."
##    echo_warning "Warning! Probability of failure to reticulate increasing."
##    echo_error "Error! Splines not fully reticulated; system unstable, terminal failure imminent!"

source colour_definitions.sh

echo_info_major()
{
    echo -e ${colour_plain_green}$*${colour_reset}
}

echo_info_minor()
{
    echo -e ${colour_plain_light_blue}$*${colour_reset}
}

echo_warning()
{
    echo -e ${colour_plain_yellow}$*${colour_reset}
}

echo_error()
{
    echo -e ${colour_plain_red}$*${colour_reset}
}

demo_echos()
{
    echo_info_major "Major thing"
    echo_info_minor "Minor thing"
    echo_warning "Warning thing"
    echo_error "Error thing"
}

if [ "$0" != "-bash" ]
then
    demo_echos
fi

## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
