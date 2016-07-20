#  ================ Source Prezto =====================

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  ================ Customization ====================

# Instantiate rbenv with shell
eval "$(rbenv init -)"

# if [ "`docker-machine status development`" = "Running" ]; then
#    eval "$(docker-machine env development)"
# fi

# export WORKON_HOME=$HOME/.virtualenvs # location where the virtual environments should live
# export PROJECT_HOME=$HOME/Devel # location of your development project directories
# source /usr/local/bin/virtualenvwrapper.sh # location of the script installed with package

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

# create pull-request
# first arg is branch you want to create PR against
# second arg (optional) is your commit message; if no message provided, it will
# open your editor so you can add a message there
function hpr() {
  hub pull-request -b $1 --browse -m ${2-''}
}

# first arg is the branch you're going to be working on
# second arg is the branch which you want to rebase on
function scpcrp() {
  gst;gco $2;gp origin $2;gco $1;gr $2;gstp
}

# Give it a # and a dir, it will cd to that dir, then `cd ..` however many times you've indicated with the number
# The number defaults to 1, the dir, if not provided, defaults to the output of the previous command
# This lets you find the dir on one line, then run the command on the next
2dir() {
  last_command="$(history | tail -2 | head -1 | sed 's/^ *[0-9]* *//')"
  count="${1-1}"
  name="${2:-$($last_command)}"
  while [[ $count > 0 ]]
  do
    name="$(dirname "$name")"
    ((count--))
  done
  echo "$name"
  cd "$name"
}

# take you to the dir of a file in a gem. e.g. `2gem rspec`
2gem () {
  cd "$(dirname $(gem which $1))"
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
alias treets='tree -I "node_modules|bower_components|typings"'

# Pruning
alias depry='ag -l "binding.pry" | xargs gsed --in-place "/binding.pry/d"'
alias deconsole='ag -l "console.log" | xargs gsed --in-place "/console.log/d"'
alias dedebug='ag -l "debugger" | xargs gsed --in-place "/debugger/d"'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
