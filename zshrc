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

# Project paths
alias p="cd ~/Projects; "
alias pt="cd ~/Projects/turing; "
alias m1="cd ~/Projects/turing/1mod; "
alias m2="cd ~/Projects/turing/2mod; "
alias m3="cd ~/Projects/turing/3mod; "
alias m4="cd ~/Projects/turing/4mod; "

# Env setup
alias vimconfig="vim ~/.dotfiles/vimrc"
alias zshconfig="vim ~/.dotfiles/zshrc"
alias tmuxconfig="vim ~/.dotfiles/tmux.conf"

# Editor
alias vim='nvim'
alias v='vim'
alias vi='vim'

# File traversal
alias c='clear;ls'
alias cl='clear'
alias dot='cd ~/.dotfiles'
alias rl='source ~/.zshrc'
alias treejs='tree -I "node_modules|bower_components"'

# Pruning
alias depry='ag -l "binding.pry" | xargs gsed --in-place "/binding.pry/d"'
alias deconsole='ag -l "console.log" | xargs gsed --in-place "/console.log/d"'
alias dedebug='ag -l "debugger" | xargs gsed --in-place "/debugger/d"'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi
