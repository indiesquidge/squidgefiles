# ================ General Config ===================

# Auto cd
setopt autocd

# Spellcheck
setopt correctall

# Use vim as editor
export VISUAL=vim

# History
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

# Autocomplete
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'm:{-_}={_-}'

# Syntax highlighting
autoload -U colors && colors
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ================ Aliases ==========================

# Easy .zshrc reload
alias reload='source ~/.zshrc'

# ================ Functions ==========================



# ================ Local Override =====================

# Allow local custimization through .zshrc_local 
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

