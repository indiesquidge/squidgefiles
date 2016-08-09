#  ================ Source Prezto =====================

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================== Custom Setup ====================

# Initialize rbenv on startup
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

# Pruning
alias depry='ag -l "binding.pry" | xargs gsed --in-place "/binding.pry/d"'
alias deconsole='ag -l "console.log" | xargs gsed --in-place "/console.log/d"'
alias dedebug='ag -l "debugger" | xargs gsed --in-place "/debugger/d"'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
