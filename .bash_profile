export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        echo "branch: ${BRANCH}"
    else
        echo ""
    fi
}

export PS1="\[$(tput bold;tput setaf 6)\]\u@\H\[$(tput sgr0;tput bold;tput setaf 7)\]:\w \[$(tput smso)\] $(parse_git_branch) \[$(tput rmso)\] \n\[$(tput bold;tput setaf 7)\]\$ \[$(tput sgr0)\]"
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH

