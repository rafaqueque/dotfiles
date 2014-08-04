# env vars
export PATH=/usr/local/bin/:/opt/local/bin:/opt/local/sbin:$PATH
export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxegedabagacad"    # osx
export LS_COLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"  # linux
export GREP_OPTIONS='--color=auto'
export TERM='xterm-256color' 

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
    echo "\[${purple}\][${ref#refs/heads/}\$(git_branch_status)]\[${reset}\]";
}

# colors based on Solarized theme
# source: https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt#L62-90
if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    black=$(tput setaf 0);
    blue=$(tput setaf 33);
    cyan=$(tput setaf 37);
    green=$(tput setaf 64);
    green_l=$(tput setaf 2);
    orange=$(tput setaf 166);
    purple=$(tput setaf 125);
    red=$(tput setaf 124);
    violet=$(tput setaf 61);
    white=$(tput setaf 15);
    yellow=$(tput setaf 136);
    gray=$(tput setaf 242);
    gray_l=$(tput setaf 247);
else
    bold='';
    reset="\e[0m";
    black="\e[1;30m";
    blue="\e[1;34m";
    cyan="\e[1;36m";
    green="\e[1;32m";
    orange="\e[1;33m";
    purple="\e[1;35m";
    red="\e[1;31m";
    violet="\e[1;35m";
    white="\e[1;37m";
    yellow="\e[1;33m";
fi;

function truncate_pwd
{
    newPWD="${PWD/#$HOME/~}"
    local pwdmaxlen=30
    [ ${#newPWD} -gt $pwdmaxlen ] && newPWD="<${newPWD:3-$pwdmaxlen}"
}

# prompt init command
function load_prompt() {
    # init
    truncate_pwd;

    # connected via ssh
    if [[ "$SSH_TTY" ]]; then
        sshIP=$(echo $SSH_CONNECTION | awk '{ print $3}')
        sshConnection="\[${red}\](ssh:$sshIP@\h)\[${reset}\] "
    fi

    # prompt
    PS1="${sshConnection}"
    PS1+="\[${reset}${blue}${bold}\]\u";
    PS1+="\[${reset}${violet}\]:\$newPWD"
    PS1+="$(git_branch)";
    PS1+="\[${reset}${blue}\]\\$ \[${reset}\]";

    case "$TERM" in
    xterm*|rxvt*|screen)
        PS1="\[\e]0;\h:\w\a\] $PS1"
        ;;
    *)
        ;;
    esac
}
PROMPT_COMMAND=load_prompt
