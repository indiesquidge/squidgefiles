# squidgefiles
Beautiful dotfiles :octopus:

Focused heavily on Tmux, Vim, Zsh, and Prezto integration.
![](http://i.imgur.com/GavxyLy.jpg)

## Installation

###Main Dotfiles:

clone the repo
```
cd ~
git clone --recursive https://github.com/indiesquidge/squidgefiles.git ~/.dotfiles
```

Symlinking is handled via [Dotbot](https://github.com/anishathalye/dotbot):
  
```
cd ~/.dotfiles
./install
```

###Vundle
Vim Plugins are handled via [Vundle](https://github.com/gmarik/Vundle.vim),
which can be installed and automatically symlinked with this command
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
After which, the custom plugins can be installed.
```
vim +PluginInstall +qall
```
The plugins I use are documented inside of my vimrc file above each plugin.

### Prezto
[Prezto](https://github.com/sorin-ionescu/prezto) is an amazing configuration 
framework for Zsh. It provides nice aliases, functions, auto-completetions, and 
pretty prompt themes.

The only downside to it is the installation, which I am in the process of making
it install automatically with my dotfiles. For now, you have to follow this process:

clone the repo into ~/.zprezto
```
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Run the following on your command line to have prezto configure it's Zsh preferences
```
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

Read the docs on the main Prezto page to change your prompt, install modules (for nicely
wrapped functions and aliases), and further customization.

###iTerm2

Colors for iTerm2 are stored in config/base16-shell. I currently use base16-default.
