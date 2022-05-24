source ~/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle z
antigen bundle virtualenv
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt
antigen bundle bobsoppe/zsh-ssh-agent
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle gpg-agent
antigen bundle iterm2
antigen bundle httpie
antigen bundle docker
antigen bundle docker-compose
antigen bundle command-not-found
# antigen bundle zsh_reload
antigen apply

export PROMPT='%{%B$FG[157]%}%2~%{$reset_color$FG[154]%}$(git_prompt_info)%{$reset_color$FG[153]%}$(virtualenv_prompt_info) %{$FG[161]%}%(1j.j:%j .)%{$reset_color%}%{%(#~$fg[red]~$fg[red])%}%#%{$fg[default]%} %{$reset_color%}'
export ZSH_THEME_GIT_PROMPT_PREFIX="["
export ZSH_THEME_GIT_PROMPT_SUFFIX="]"
export ZSH_THEME_GIT_PROMPT_DIRTY=":!"
export ZSH_THEME_GIT_PROMPT_STASHED=":$"
export ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="["
export ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="]"

# custom aliases
source ~/.aliases

export TERM='xterm-256color'
export EDITOR=nvim
export DEFAULT_USER=$(whoami)
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export JWT_SECRET=secret
export JWT_ALGORITHM=HS256
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
