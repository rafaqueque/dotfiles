export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# get current branch in git repo
# found here: http://thepugautomatic.com/2008/12/git-dirty-prompt/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo ' *'
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# sublime text-like search
function ctrlf_sublimetext() {
    grep --color=always -Iirn3 '$@' | less -R
}
alias ctrlf=ctrlf_sublimetext

export PS1='\[$(tput bold;tput setaf 6)\]\u@\H\[$(tput sgr0;tput bold;tput setaf 7)\]:\w \[$(tput smso)\]$(parse_git_branch)\[$(tput rmso)\] \n\[$(tput bold;tput setaf 7)\]\$ \[$(tput sgr0)\]'
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH

