#  ================ Source Prezto =====================

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================== Custom Setup ====================

# Set default shell editor
export VISUAL=vim
export EDITOR=VISUAL

# Initialize rbenv on startup
# eval "$(rbenv init -)"

# Add SSH identity
{ ssh-add -K ~/.ssh/id_rsa } &> /dev/null

# Start gpg-agent or set up the GPG_AGENT_INFO variable if it's already running
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

# Export the GPG_TTY variable every time a new TTY start
export GPG_TTY=$(tty)

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

# create missing subfolders before touching file
supervim() {
  if [ $# -lt 1 ]; then
    echo "Missing argument";
    return 1;
  fi

  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    nvim -- "$f"
  done
}

# clone and cd into repo
function clone() {
  git clone $1 && cd $(basename ${1%.*})
}

# create GitHub pull-request
# first arg is branch you want to create PR against
# second arg (optional) is your commit message; if no message provided, it will
# open your editor so you can add a message there
function hpr() {
  hub pull-request -b $1 --browse -m ${2-''}
}

#  ================ Aliases ===========================

# Env setup
alias vimconfig="vim ~/.dotfiles/vimrc"
alias zshconfig="vim ~/.dotfiles/zshrc"
alias tmuxconfig="vim ~/.dotfiles/tmux.conf"

# Editor
alias vi='/usr/local/bin/vim'
# if neovim installed, alias vim to neovim
if hash nvim 2>/dev/null; then
  alias vim='nvim'
  alias v='vim'
fi

# File traversal
alias c='clear;ls'
alias cl='clear'
alias dot='cd ~/.dotfiles'
alias rl='source ~/.zshrc'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
