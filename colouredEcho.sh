## <DF>
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
##    echoInfoMajor "Performing first stage processing of large dataset..."
##    echoInfoMinor "  - Doing the first thing..."
##    echoInfoMinor "  - Reticulating splines..."
##    echoInfoMajor "Complete."
##    echoError "Error! Splines not fully reticulated; system unstable, terminal failure imminent!"

echoInfoMajor()
{
    echo -e "\033[32m$*"
    echo -en "\033[0m"
}

echoInfoMinor()
{
    echo -e "\033[94m$*"
    echo -en "\033[0m"
}

echoError()
{
    echo -e "\033[31m$*"
    echo -en "\033[0m"
}
