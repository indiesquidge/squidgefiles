#  ================ Source Prezto =====================

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================ Customization =====================

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Instantiate rbenv with shell
eval "$(rbenv init -)"

#  ================ Alias Functions ===================

# ls automatically after cd
function cs() {
  if [ $# -eq 0  ]; then
    cd && ls
  else
    cd "$*" && ls
  fi
}
alias cd='cs'

# mkdir and cd into it in one action
function mkcd {
  mkdir $1
  cd $1
}

# clone and cd into repo
function clone() {
  git clone $1 && cd $(basename ${1%.*})
}

#  ================ Aliases ===========================

alias p="cd ~/Projects; "
alias pt="cd ~/Projects/Turing; "
alias m1="cd ~/Projects/Turing/1mod; "
alias m2="cd ~/Projects/Turing/2mod; "

alias vimconfig="vim ~/.dotfiles/vimrc"
alias zshconfig="vim ~/.dotfiles/zshrc"
alias tmuxconfig="vim ~/.dotfiles/tmux.conf"

alias v='vim'

alias c='clear;ls'
alias cl='clear'
alias dot='cd ~/.dotfiles'
alias rl='source ~/.zshrc'

alias hpr='gPb > /dev/null && hub pull-request | xargs open'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
