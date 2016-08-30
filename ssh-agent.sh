## ┌────────────────────────────────────────────────────────────────────────────┐
## │ <DF>                                                                       │
## SSH-agent configuration
## Refer to https://confluence.atlassian.com/display/BITBUCKET/Set+up+SSH+for+Git

SSH_ENV="$HOME/.ssh/environment"
SSH_KEY_DIR="$HOME/.ssh/keys"

mkdir -p $SSH_KEY_DIR
sudo chmod --recursive go-rwX $SSH_KEY_DIR

function start_agent
{
    echoInfoMajor "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    if [ -d $SSH_KEY_DIR/services ]
    then
        /usr/bin/ssh-add $SSH_KEY_DIR/services/*.id_rsa
    fi
}

if [ -f $SSH_ENV ]
then
    . $SSH_ENV > /dev/null
    if ! ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ > /dev/null
    then
        start_agent
    fi
else
    start_agent;
fi
## │ </DF>                                                                      │
## └────────────────────────────────────────────────────────────────────────────┘
