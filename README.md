```
                              __                     ___      ___
                       __    /\ \                  /'___\ __ /\_ \
  ____     __   __  __/\_\   \_\ \     __      __ /\ \__//\_\\//\ \      __    ____
 /',__\  /'__`\/\ \/\ \/\ \  /'_` \  /'_ `\  /'__`\ \ ,__\/\ \ \ \ \   /'__`\ /',__\
/\__, `\/\ \ \ \ \ \_\ \ \ \/\ \ \ \/\ \ \ \/\  __/\ \ \_/\ \ \ \_\ \_/\  __//\__, `\
\/\____/\ \___, \ \____/\ \_\ \___,_\ \____ \ \____\\ \_\  \ \_\/\____\ \____\/\____/
 \/___/  \/___/\ \/___/  \/_/\/__,_ /\/___ \ \/____/ \/_/   \/_/\/____/\/____/\/___/
              \ \_\                    /\____/
               \/_/                    \_/__/

Dotfiles focused heavily on Tmux, Vim, Zsh, and Prezto integration.
```
![](http://i.imgur.com/LqxwqWo.jpg)

## Starting Fresh

* Download [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12).
Open it to agree to the Xcode license, or run
```sh
sudo xcodebuild -license
```
* Download [iTerm2](https://www.iterm2.com/downloads.html)
* Install Homebrew:
```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install Zsh

OS X ships with Zsh, but it is old (4.3.11). We want to install the latest version.
```sh
brew install zsh
```
Use the newer version we just installed and set it as the default shell.
```sh
sudo zsh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh
```
* Install Git
```sh
brew install git
```
Set the name, email, and editor for git
```sh
git config --global user.name "Austin Wood"
git config --global user.email "i@austinwood.me"
git config --global core.editor vim
```
Follow [this](https://help.github.com/articles/generating-ssh-keys/) article to
be able to authenticate with GitHub from Git. This will grant you the action to
clone using SSH (more secure), and also make it so that you don't have to enter
in your GitHub username and password every time you push to a remote branch.

* Install Vim

OS X ships with Vim by default. However, just like Zsh, it is an outdated
version (7.3). UltiSnips, one of the plugins for autocomplete, requires Vim >= 7.4
to work. Neocomplete requires Vim to be installed with Lua as a dependency.
```sh
brew install vim --with-lua
```
Hide the system Vim so the new version is found first
```sh
sudo mv /usr/bin/vim /usr/bin/vim72
```
Running `which vim` should now return `/usr/local/bin/vim`

## Installation

### Main Dotfiles

clone the repo
```sh
git clone --recursive https://github.com/indiesquidge/squidgefiles.git ~/.dotfiles
```

Symlinking is handled via [Dotbot](https://github.com/anishathalye/dotbot):
```sh
cd ~/.dotfiles
./install
```

### Vundle
Vim Plugins are handled via [Vundle](https://github.com/gmarik/Vundle.vim),
which can be installed and automatically symlinked with this command
```sh
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
After which, the custom plugins can be installed.
```sh
vim +PluginInstall +qall
```

### Prezto
[Prezto](https://github.com/indiesquidge/prezto) is a configuration framework
for Zsh. It provides nice aliases, functions, auto-completions, and pretty
prompt themes.

clone the repo into ~/.zprezto
```sh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Run the following on your command line to have prezto configure it's Zsh preferences
```sh
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
It will probably return `ln: /Users/<username>/.zshrc: File exists`. This is
fine. We have our own `.zshrc` file that we want to use anyway.

Open a new terminal window to see the changes. You may see something like
`Last login: Mon Jul 13 12:33:01 on ttys000`, which is ugly and annoying.
Let's fix that.
```sh
touch ~/.hushlogin
```
You may also see `/Users/<username>/.zshrc:15: command not found: rbenv`. This
is because we have yet to install rbenv to manage our Ruby versions.
```sh
brew install rbenv ruby-build
```
Opening a new terminal tab should show just your prompt. Nice and clean :sparkles:.

#### Use "correct" Ruby in Vim
By default, Vim will use your system ruby. You can check this by running
```sh
!echo $PATH
```
Note how the paths remains starting with `/usr/bin`.

This is [a known problem introduced by Apple in OS X 10.5 Leopard](https://github.com/dotphiles/dotzsh#mac-os-x).

Since we are using Zsh as our shell, it affects us. The `vim-rbenv` plugin will
fix this.
```sh
sudo mv /etc/zshenv /etc/zshrc
```
is a great solution because it still enables the execution of the `path_helper`
on interactive shells, and this plugin is already installed with these dotfiles. If
you would prefer to not use the plugin, you can run
```sh
sudo chmod ugo-x /usr/libexec/path_helper
```
which should also fix the issue.

Now `!echo $PATH` should return the rbenv ruby version from `~/.rbenv/shims`.

### Tmux & terminal battery (optional)
[Tmux](https://tmux.github.io/) is a terminal multiplexer, which is a fancy way
of saying you can run multiple shell instances on different "panes" within the
same terminal window, as well as create tabs. It eliminates the hassle of
creating multiple windows and tabs on the application level.
```sh
brew install tmux
```

[Battery](https://github.com/Goles/Battery) is a script to display the battery
status on the tmux status bar.
```sh
brew tap Goles/battery
brew install battery
```
If you'd like to get rid of the :zap: that appears next to the battery when it's
charging (since its ugly)
```sh
vim /usr/local/bin/battery
```
Remove just the emoji on line 113. You could add in something else to signify
a charging status. I like to use `++ `.

It would also be wise to remove the `elseif` statement on line 115. The final
`print_status()` function should look something like this
```sh
if ((connected)); then
  GRAPH="++ "
else
  GRAPH=""
fi
```

_Note:_ to save and exit this file, you need to run `:wq!`

## Configuration & Preferences

### Fonts & Colors

#### Fonts
Both Vim and Tmux are using custom font icons for their status bars. To install
the font, save it in Fontbook.app
```sh
open ~/.dotfiles/config/fonts/PowerlineSymbols-Powerline.otf
```
Font for terminal text:
```sh
open ~/.dotfiles/config/fonts/Sauce\ Code\ Powerline\ Light.otf
```

_Note:_ if either of these `open` commands give you back an error, it is because
Tmux, LSOpenURLsWithRole(), and/or OS X Yosemite do not play nicely together. To
fix this, first try exiting out of your Tmux instance (if you're in one) and
re-running the command. If that does not work, you may need a dependency that
worked for me as of July 13, 2015.
```sh
brew install reattach-to-user-namespace
```
The line to use this is already in place in `tmux.conf` on line 26.

To use these fonts, go to iTerm > Preferences > Profiles > Text. For both
Regular Font and Non-ASCII Font choose 14pt Sauce Code Pro Powerline Light.

#### Colors
Vim ships from this repo already using seoul256. To use the same font within the
iTerm2 app, do the following: * Under iTerm > Preferences > Profiles > Colors,
choose "Load Presets... > Import", press ⇧⌘g (shift-cmd-g) and type in the file
path for seoul256 colors `~/.dotfiles/config/`, and select `seoul256.itermcolors`.
Unfortunately, the background color of seoul256 for iTerm does not match seoul256
for terminal Vim. To fix this, simply darken the background color under Basic
Colors for iTerm.

Now the color scheme should be coherent and seamless across both the editor and
the terminal.

### iTerm2

Open up preferences (iTerm > Preferences _-or-_ ⌘,)
* Under General,
  * Uncheck "Use Lion-style Fullscreen windows
* Under Profile,
  * Under General, fill in Send text at start to "tmux"
  * Under Text, uncheck everything under Text Rendering
  * Under Window, adjust transparency based on personal preference, and set the
    Settings for New Windows Style to       Fullscreen
  * Under Terminal, uncheck everything for Notifications
* Under Keys
  * Enable system-wide hotkey to whatever you like. Right now I'm digging `^e`
    since it's on home row.
  * Under Global Shortcut Keys, add the following, all of which should have an
    action of ignore: ⌘t, ⌘r, ⌘w

## Random Useful Packages
* `brew install brew-rmtree` - uninstall all dependencies with a package (i.e. `brew rmtree python`)
* `brew install ag` - the silver searcher for grepping amongst files (i.e. `ag hello`)
* `brew install tree` - tree structure from given folder (i.e. `tree my-rails-app`)

## Random Useful Gems
* `gem install lolcat` - rainbows and unicorns! (i.e. `/usr/sbin/system_profiler SPHardwareDataType | lolcat`)
* `gem install octodown` - github markdown previewing from the terminal (i.e. `octodown README.md`)
