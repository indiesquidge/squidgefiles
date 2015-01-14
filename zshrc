#  ================ Source Prezto =====================
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================ Customization =====================

source ~/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Instantiate rbenv with shell
eval "$(rbenv init -)"

# Base16 Shell
BASE16_SCHEME="tomorrow"
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

#  ================ Aliases ===========================

alias pt="cd ~/Projects/Turing; "
alias vimconfig="vim ~/.dotfiles/vimrc"
alias zshconfig="vim ~/.dotfiles/zshrc"
alias tmuxconfig="vim ~/.dotfiles/tmux.conf"
alias cls='clear;ls'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
