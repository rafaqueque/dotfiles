# get current branch in git repo
# found here: http://thepugautomatic.com/2008/12/git-dirty-prompt/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo ' *' 
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ branch: $(tput bold)\1$(parse_git_dirty) /"
}

# sublime text-like search
function ctrlf_sublimetext() {
    grep --color=always -Iirn3 '$@' | less -R
}
alias ctrlf=ctrlf_sublimetext


# daily logger
# usage: doing "stuff ..."
function insert_daily_log_entry() {
    # some vars
    doing_message="$@"
    doing_dir=~/daily_logger/
    doing_file="log_$(date '+%d-%m-%y').txt"
    doing_output=$doing_dir$doing_file

    # create file if doesn't exist
    if [ ! -f $doing_output ]; then
        mkdir $doing_dir
        echo "" > $doing_output 
    fi

    # append message to the end of file
    echo "[$(date +%T)] $doing_message" >>$doing_output
}
alias doing=insert_daily_log_entry


# custom prompt
export PS1='\[$(tput bold;tput setaf 7)\]\u@\H\[$(tput sgr0)\]:\w \[$(tput setaf 3;tput smso)\]$([ \j -gt 0 ] && echo " jobs: $(tput bold)\j ")\[$(tput sgr0)\] \[$(tput setaf 3;tput smso)\]$(parse_git_branch)\[$(tput sgr0)\] \n\[$(tput bold;tput setaf 1)\]\$\[$(tput sgr0)\] '

# env vars
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
