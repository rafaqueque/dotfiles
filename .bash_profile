# get current branch in git repo
# found here: http://thepugautomatic.com/2008/12/git-dirty-prompt/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

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
bold=$(tput bold)
reset=$(tput sgr0)
color1=$(tput setaf 6)
color2=$(tput setaf 3)
export PS1="\[$color1$bold\]\\u@\\h\[$reset$color2\]:\\w \[$color2$bold\]\\j\[$reset\] \[$color1$bold\]\\$\[$reset\] "

# env var\]s
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
