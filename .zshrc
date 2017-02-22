source ~/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle z

setopt NO_EXTENDED_GLOB
export PROMPT='%{%B$FG[157]%}%2~%{$reset_color$FG[154]%}$(git_prompt_info) %{$FG[161]%}%(1j.j:%j .)%{$reset_color%}%{%(#~$fg[red]~$fg[red])%}%#%{$fg[default]%} %{$reset_color%}'
export ZSH_THEME_GIT_PROMPT_PREFIX="["
export ZSH_THEME_GIT_PROMPT_SUFFIX="]"
export ZSH_THEME_GIT_PROMPT_DIRTY=":!"
export ZSH_THEME_GIT_PROMPT_STASHED=":$"

antigen apply

# custom aliases
source ~/.aliases

export TERM='xterm-256color'
export EDITOR=nvim
export DEFAULT_USER=$(whoami)
export HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"
export PATH=/usr/local/sbin:$PATH
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home"
export JWT_SECRET=secret
export JWT_ALGORITHM=HS256
export PATH=${JAVA_HOME}/bin:$PATH
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
