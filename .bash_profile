# git branch
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "$color2[$bold"${ref#refs/heads/}"$reset$color2]$reset";
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
color1=$(tput setaf 2)
color2=$(tput setaf 3)
export PS1="\[$bold\]\\u@\\h\[$reset\]:\\w\$(git_branch) \[$color1$bold\]\\$\[$reset\] "

# env var\]s
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
