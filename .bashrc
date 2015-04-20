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
function git_branch {
    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then
        # ensure index is up to date
        git update-index --really-refresh  -q &>/dev/null
        # check for uncommitted changes in the index
        if ! $(git diff --quiet --ignore-submodules --cached); then
            s="$s+";
        fi
        # check for unstaged changes
        if ! $(git diff-files --quiet --ignore-submodules --); then
            s="$s!";
        fi
        # check for untracked files
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            s="$s?";
        fi
        # check for stashed files
        if $(git rev-parse --verify refs/stash &>/dev/null); then
            s="$s$";
        fi
    fi

    [ -n "$s" ] && s=":$s"

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "(${ref#refs/heads/}$s)";
}

# colors based on Solarized theme
# source: https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt#L62-90
if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    hl=$(tput smso);
    bold=$(tput bold);
    reset=$(tput sgr0);
    black=$(tput setaf 0);
    blue=$(tput setaf 33);
    cyan=$(tput setaf 37);
    green=$(tput setaf 64);
    green_l=$(tput setaf 2);
    pink=$(tput setaf 5);
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
    pink="\e[01;31m";
fi;

# connected via ssh?
if [[ "$SSH_TTY" ]] || [[ "$SSH_CONNECTION" ]]; then
    sshConnection="\[${gray_l}${hl}\][\[${bold}\]ssh\[${reset}${hl}${gray_l}\]:\u@\h]\[${reset}\]"
fi

# running inside screen or tmux?
if [ -n "$TMUX" ]; then insideTmux="\[${gray}${hl}\][t]\[${reset}\]"; fi
if [ -n "$STY" ]; then insideScreen="\[${gray}${hl}\][s]\[${reset}\]"; fi

# prompt
export PS1="\[${reset}\]${sshConnection}";
export PS1+="\[${reset}\]${insideTmux}";
export PS1+="\[${reset}\]${insideScreen}";
export PS1+="\[${reset}${blue}\] \w";
export PS1+="\[${reset}${purple}\]\$(git_branch)";
export PS1+="\[${reset}${gray}\] \j:";
export PS1+="\[${reset}${gray_l}\]\\$ \[${reset}\]";
# /end prompt

case "$TERM" in
xterm*|rxvt*|screen)
    export PS1="\[\e]0;\h:\w\a\]$PS1"
    ;;
*)
    ;;
esac
export PATH=/usr/local/sbin:$PATH

# custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
