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
![](http://i.imgur.com/HDRTgWf.png)

## Starting Fresh

* Download [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12).
Open it to agree to the Xcode license, or run
```zsh
sudo xcodebuild -license
```
* Download [iTerm2](https://iterm2.com/nightly/latest)
* Install Homebrew:
```zsh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install Zsh

OS X ships with Zsh, but it is old (5.0.8). We want to install the latest version.
```zsh
brew install zsh
```
Use the newer version we just installed and set it as the default shell.
```zsh
sudo zsh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh
```
* Install Git
```zsh
brew install git
```
Set the name, email, and editor for git
```zsh
git config --global user.name "Austin Wood"
git config --global user.email "i@austinwood.me"
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore
```
Follow [this](https://help.github.com/articles/generating-ssh-keys/) article to
be able to authenticate with GitHub from Git. This will grant you the action to
clone using SSH (more secure), and also make it so that you don't have to enter
in your GitHub username and password every time you push to a remote branch.

(Optional): Download and set up `gpg` to properly [sign your commits](https://help.github.com/articles/signing-commits-using-gpg/)
```zsh
git config --global commit.gpgsign true
```

* Install Vim

OS X ships with Vim by default. However, just like Zsh, it is an outdated
version (7.3). Neocomplete requires Vim to be installed with Lua as a dependency.
```zsh
brew install vim --with-lua
```
Hide the system Vim so the new version is found first
```zsh
sudo mv /usr/bin/vim /usr/bin/vim73
```
Running `which vim` should now return `/usr/local/bin/vim`

**NOTE**: If you're running OS X 10.11 (El Capitan) and are having issues with
moving the system `vim`, please see this [Stack Exchange answer on the issue](http://apple.stackexchange.com/a/202969).

* Install Neovim (optional)

Neovim is the "next gen Vim". The main goals of creating this fork of Vim were
to refactor the code to improve maintenance; implement new advanced features;
expose a better, more powerful plugin system; and have a more open development
model, where contributions are more easily accepted. So far, they've done a great
job, and many plugins have come out that make active use of the new features,
particularly the asynchronous nature of Neovim. Keep in mind that Neovim is still
very new (v0.1.4). While it is being actively worked on, it may break at times.
I personally have never run into any detrimental issues with it so far, and have
loved reaping in the new benefits. To install, run
```zsh
brew install neovim/neovim/neovim
```

One of the plugins I use, `deoplete`, which is a asynchronous completion framework
for neovim, requires Python3. To install this, run
```zsh
brew install python3
```

Then enable the `neovim` Python3 interface with pip:
```zsh
pip3 install neovim
```

## Installation

### Main Dotfiles

clone the repo
```zsh
git clone --recursive https://github.com/indiesquidge/squidgefiles.git ~/.dotfiles
```

Symlinking is handled via [Dotbot](https://github.com/anishathalye/dotbot):
```zsh
cd ~/.dotfiles
./install
```

### Vim Plug
Vim Plugins are handled via [Plug](https://github.com/junegunn/vim-plug),
which can be installed with this command
```zsh
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
After which, the repository plugins can be installed. By opening a `vim` buffer
and running `:PlugInstall`

### Prezto
[Prezto](https://github.com/indiesquidge/prezto) is a configuration framework
for Zsh. It provides nice aliases, functions, auto-completetions, and pretty
prompt themes.

clone the repo into ~/.zprezto
```zsh
git clone --recursive https://github.com/indiesquidge/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Run the following on your command line to have prezto configure it's Zsh preferences
```zsh
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
```zsh
touch ~/.hushlogin
```
Opening a new terminal tab should show just your prompt. Nice and clean :sparkles:.

### Tmux & terminal battery (optional)
[Tmux](https://tmux.github.io/) is a terminal multiplexer, which is a fancy way
of saying you can run multiple shell instances on different "panes" within the
same terminal window, as well as create tabs. It eliminates the hassle of
creating multiple windows and tabs on the application level.
```zsh
brew install tmux
```
You should now be able to run `tmux` to enter a new session. The Tmux leader is
set to `<C-a>`. A few basic commands to make sure it's working could be `<C-a> s`
for horizontal splits and `<C-a> v` for vertical splits. For a full list of Tmux
commands, see [this cheat sheet](https://gist.github.com/MohamedAlaa/2961058).

[Battery](https://github.com/Goles/Battery) is a script to display the battery
status on the tmux status bar.
```zsh
brew tap Goles/battery
brew install battery
```
If you'd like to get rid of the :zap: that appears next to the battery when it's
charging (since its ugly)
```zsh
vim /usr/local/bin/battery
```
Remove just the emoji on line 113. You could add in something else to signify
a charging status. I like to use `++ `.

It would also be wise to remove the `elseif` statement. The final `print_status()`
function should look something like this
```zsh
if ((connected)); then
  GRAPH="++ "
else
  GRAPH=""
fi
```

**NOTE**: to save and exit this file, you need to run `:wq!`

## Configuration & Preferences

### Fonts & Colors

#### Fonts
Both Vim and Tmux are using custom font icons for their status bars. To install
the font, save it in Fontbook.app
```zsh
open ~/.dotfiles/config/fonts/PowerlineSymbols-Powerline.otf
```
Font for custom terminal and vim text:
```zsh
open ~/.dotfiles/config/fonts/OperatorMono-XLight.otf
```

**NOTE**: if either of these `open` commands give you back an error, it is because
Tmux, LSOpenURLsWithRole(), and/or OS X Yosemite do not play nicely together. To
fix this, first try exiting out of your Tmux instance (if you're in one) and
re-running the command. If that does not work, you may need a dependency that
worked for me as of July 13, 2015.
```zsh
brew install reattach-to-user-namespace
```
The line to use this is already in place in `tmux.conf` on line 26.

To use these fonts, go to iTerm > Preferences > Profiles > Text.
For Font, choose 14pt Operator Mono XLight
Select "Anti-aliased", select "Use a different font for non-ASCII text"
For Non-ASCII Font, choose 14pt Sauce Code Powerline Light

#### Colors
Vim ships from this repo already using seoul256. To use the same font within the
iTerm2 app, do the following: * Under iTerm > Preferences > Profiles > Colors,
choose "Load Presets... > Import", press ⇧⌘g (shift-cmd-g) and type in the file
path for seoul256 colors `~/.dotfiles/config/`, and select `seoul256.itermcolors`.
Unfortunately, the background color of seoul256 for iTerm does not match seoul256
for terminal Vim. To fix this, simply darken the background color under Basic
Colors for iTerm (something close to #131313 is good).

Now the color scheme should be coherent and seamless across both the editor and
the terminal.

### iTerm2 Preferences

Open up preferences (iTerm > Preferences _-or-_ ⌘,)
* Under General,
  * Uncheck "Native full screen windows" to allow full screen without window switching
* Under Profile,
  * Under General, fill in "tmux" for "Send text at start" to start tmux for new windows automatically
  * Under Text, check "Italic text allowed"; uncheck everything else
  * Under Window,
    * Adjust transparency based on personal preference
    * Set the settings for "Style" to Fullscreen
  * Under Terminal
    * Under Terminal Emulation, choose "xterm-256color-italic" for "Report Terminal Type" (manually type in if needed)
    * Under Notifications, check "Silence bell"; uncheck everything else
* Under Keys
  * Enable system-wide hotkey to whatever you like. Right now I'm digging `^e`
    since it's on home row (`caps lock` mapped to `control`)
  * Under "Key Mappings", add the following, all of which should have an action of ignore: ⌘t, ⌘r, ⌘w

**NOTE**: load and compile the "xterm-256color-italic" file for terminal use, run
```sh
tic ~/.dotfiles/config/iterm2/xterm-256color-italic.terminfo
```

## Random Useful Packages
* `brew tap beeftornado/rmtree && brew install beeftornado/rmtree/brew-rmtree` uninstall all dependencies with a package (e.g. `brew rmtree python`)
* `brew install ag` - the silver searcher for grepping amongst files (e.g. `ag "hello world" some/file/path`)
* `brew install hub` - GitHub CLI commands (e.g. `hub create`, `hub pull-request`)
* `brew install tree` - tree structure from given folder (e.g. `tree my-rails-app`)
* `brew install httpie` - human-friendly, command line HTTP client (e.g. `http httpie.org`)
* `brew install gnu-sed` - text transformation and filterting (e.g. `sed -i -- 's/foo/bar/g' *`)
* `brew install jq` - `sed` for JSON data (e.g. `http swapi.co/api/planets/1/ | jq '.'`)
* `brew install youtube-dl` - YouTube CLI (e.g. `youtube-dl https://youtu.be/dQw4w9WgXcQ`)

## Random Useful Gems
* `gem install lolcat` - rainbows and unicorns! (i.e. `/usr/sbin/system_profiler SPHardwareDataType | lolcat`)
* `gem install octodown` - github markdown previewing from the terminal (i.e. `octodown README.md`)

---

#### UPDATES

_(10-20-2015):_ Something (I am not sure what yet) in the [2.1 Tmux](releases)
update has broken some of my tmux settings. One of lesser importance (but still
worth noting) is the `mouse` options. The lines

[releases]: https://github.com/tmux/tmux/releases

```conf
setw -g mode-mouse off
set -g mouse-select-pane off
set -g mouse-resize-pane off
set -g mouse-select-window off
```

Have been replaced with the global

```conf
set -g mouse off
```

There is a more important issue. When I am zoomed into a pane so that it takes
up the whole screen, I no longer have the ability to switch panes directly from
the zoomed in pane. I must explicitly zoom out of the pane before I can change
to another pane. This is rather annoying since it's a whole extra step to get to
another pane.

After some digging, I found the [diff](https://github.com/tmux/tmux/commit/a05c27a7e1c4d43709817d6746a510f16c960b4b.diff)
that created the issue, and have since created a patch that fixes the problem in
2.1. It has been [merged](https://github.com/Homebrew/homebrew/pull/45230) into
the stable Homebrew bottle for Tmux and shouldn't be a problem for any future
download via Homebrew.
