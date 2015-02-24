#  ================ Source Prezto =====================
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================ Customization =====================

source ~/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Instantiate rbenv with shell
eval "$(rbenv init -)"

# Base16 Shell
BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

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
alias dot='cd ~/.dotfiles'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
