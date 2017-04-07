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
    echo -e ${ANSI_ESCAPE}${ANSI_COLOUR_GREEN}$*${ANSI_RESET}
}

echo_info_minor()
{
    echo -e ${ANSI_ESCAPE}${ANSI_COLOUR_LIGHT_BLUE}$*${ANSI_RESET}
}

echo_warning()
{
    echo -e ${ANSI_ESCAPE}${ANSI_COLOUR_YELLOW}$*${ANSI_RESET}
}

echo_error()
{
    echo -e ${ANSI_ESCAPE}${ANSI_COLOUR_RED}$*${ANSI_RESET}
}

demo_echos()
{
    echo_info_major "Major thing"
    echo_info_minor "Minor thing"
    echo_warning "Warning thing"
    echo_error "Error thing"
}

## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
