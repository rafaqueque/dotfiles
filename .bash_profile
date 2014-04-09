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
export PS1='[\[$(tput sgr0;tput bold)\]\u@\H:\[$(tput sgr0)\]\w] \[$(tput bold;tput setaf 1)\]\$\[$(tput sgr0)\] '

# env vars
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
