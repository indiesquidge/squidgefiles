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
alias dot='cd ~/.dotfiles'
alias rl='source ~/.zshrc'

alias hpr='gPb > /dev/null && hub pull-request | xargs open'

#  ================ Local version =====================

if [ -f ~/.zsh_local ]; then
  source ~/.zshrc_local
fi

#  ================ Git Create Remote =================

github-create() {
  repo_name=$1

  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    echo "Repo name (hit enter to use '$dir_name')?"
    read repo_name
  fi

  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi

  username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
  fi

  token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    invalid_credentials=1
  fi

  if [ "$invalid_credentials" = "1" ]; then
    return 1
  fi

  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  echo " done."

  echo -n "Pushing local code to remote ..."
  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  echo " done."
}
