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

# git branch in prompt
function git_branch_status {
    [[ -n "$(git status -s 2> /dev/null)" ]] && echo "*"
}
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "${c_yellow}[${ref#refs/heads/}\$(git_branch_status)]${c_reset_t}";
}

# truncate working dir
function truncate_working_dir() {
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=25
    #   Indicator that there has been directory truncation:
    #trunc_symbol="<"
    local trunc_symbol="<"
    if [ ${#PWD} -gt $pwdmaxlen ]
    then
        local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
        newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
    else
        newPWD=${PWD}
    fi
}

# colors
c_reset="\[\e[0m\]"
c_green="\[\033[0;32m\]"
c_green_l="\[\033[1;32m\]"
c_yellow="\[\033[0;33m\]"
c_yellow_l="\[\033[1;33m\]"
c_red="\[\033[0;31m\]"
c_red_l="\[\033[1;31m\]"
c_gray="\[\033[1;30m\]"
c_gray_l="\[\033[0;37m\]"
c_blue="\[\033[0;34m\]"
c_blue_l="\[\033[1;34m\]"
c_cyan="\[\033[0;36m\]"
c_cyan_l="\[\033[1;36m\]"
c_purple="\[\033[0;35m\]"
c_purple_l="\[\033[1;35m\]"
c_bold="\[\$(tput bold)\]";
c_reset_t="\[\$(tput sgr0)\]";

# prompt init command
function load_prompt() {
    truncate_working_dir

    # prompt
    PS1="${c_cyan}\u@\h:${c_reset_t}${c_green}\$newPWD${c_reset_t}$(git_branch) ${c_bold}\\$ ${c_reset_t}"
}
PROMPT_COMMAND=load_prompt

# env vars
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS=LSCOLORS # linux
export GREP_OPTIONS='--color=auto'
