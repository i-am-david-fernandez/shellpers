## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## These 'echo' wrappers provide a convenient way to produce coloured terminal messages from scripts using
## simple escape codes. They are intended for use in terminals with a dark-background theme (e.g., white text
## on black background).

## The names suggest their intended use:
##   - InfoMajor produces bright green text for important information,
##   - InfoMinor produces comparatively dull blue text for information of secondary importance,
##   - Error produces bright red text for critically-important information.

## Usage:
##  echoXYZ "This is a coloured message!"
## e.g.,
##    echo_info_major "Performing first stage processing of large dataset..."
##    echo_info_minor "  - Doing the first thing..."
##    echo_info_minor "  - Reticulating splines..."
##    echo_info_major "Complete."
##    echo_error "Error! Splines not fully reticulated; system unstable, terminal failure imminent!"

echo_info_major()
{
    echo -e "\033[32m$*"
    echo -en "\033[0m"
}

echo_info_minor()
{
    echo -e "\033[94m$*"
    echo -en "\033[0m"
}

echo_error()
{
    echo -e "\033[31m$*"
    echo -en "\033[0m"
}
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
