```
  ____              _     _             __ _ _
 / ___|  __ _ _   _(_) __| | __ _  ___ / _(_) | ___  ___
 \___ \ / _` | | | | |/ _` |/ _` |/ _ \ |_| | |/ _ \/ __|
  ___) | (_| | |_| | | (_| | (_| |  __/  _| | |  __/\__ \
 |____/ \__, |\__,_|_|\__,_|\__, |\___|_| |_|_|\___||___/
           |_|              |___/

Opinionated dotfiles for Zsh, Neovim, and Tmux
```

![](http://i.imgur.com/9uXFru1.jpg)

# Table of Contents

* [Dependencies](#dependencies)
* [Dotfile Installation](#dotfiles)
* [Configuration & Preferences](#configuration)
* [iTerm2 Preferences](#iterm-preferences)
* [Random Useful Packages](#packages)

---

## <a name="dependencies"></a>Dependencies

### Install Xcode Command Line Tools

```
xcode-select --install
```

### Download iTerm2

```
cd ~/Downloads && { \
  curl -O https://iterm2.com/downloads/stable/iTerm2-3_1_6.zip; \
  unzip -q iTerm2-3_1_6.zip; \
  mv iTerm.app /Applications; \
  rm iTerm3-3_1_6.zip; \
  cd -; \
}
```

### Install Homebrew

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install Zsh

macOS ships with Zsh, but it is old (5.0.8). We want to install the latest version.

```
brew install zsh
```

Use the newer version we just installed and set it as the default shell.

```
sudo zsh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh
```

### Install Git

```
brew install git
```

Personal configuration of git

```
git config --global user.name "Austin Wood"
git config --global core.editor nvim
git config --global core.excludesfile ~/.gitignore
```

As a matter of personal taste, I prefer to [hide my email address](https://help.github.com/articles/keeping-your-email-address-private/)
on GitHub. I also like to work with different email addresses for different Git
repositories, generally to separate vocational and personal projects.

As of Git 2.8, I can tell Git not to guess, but rather to insist that I set
`user.name` and `user.email` explicitly before it will let me commit to a new
repository. To ensure this happens, I set the following global config flag.

```
git config --global user.useconfigonly true
```

Follow [this](https://help.github.com/articles/generating-ssh-keys/) article to
be able to authenticate with GitHub from Git. This will grant you the action to
clone using SSH (more secure), and also make it so that you don't have to enter
in your GitHub username and password every time you push to a remote branch.

### Install GPG to sign commits (optional)

Git allows you to sign your commits, which is a super cool feature in that it
allows you to prove that you're, well, really _you_. To get started, follow the
5-6 related articles [here](https://help.github.com/articles/signing-commits-using-gpg/) that will help you set up a new GPG key, add it to
GitHub, etc.

Then follow [this gist](https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b) to learn how to setup GPG. The only changes I would make
what's provided in that gist is to use `pinentry-curses` in place of
`pinentry-mac` in `gpg-agent.conf`. If you don't have `pinentry`, you can
install it through brew (it's just called `pinentry` on the install).

_**NOTE**: the contents of `.profile` from the gist mentioned above are already
in place in the `zshrc` of this repository, so no need to worry about that._

Then you can set your git config to require a signature using GPG

```
git config --global commit.gpgsign true
git config --global gpg.program /usr/local/bin/gpg
```

Now when you make some changes in a git directory, committing those changes will
open an in-terminal dialog for you to enter your GPG key password that you set
up when following the GitHub tutorials linked to above.

_**NOTE**: if you plan on using different GPG keys associated with work and
personal emails, but have instantiated the keys on different computers, you can
follow these steps to get external keys onto another machine._

You can use this command to see which keys you currently have on your machine

```
gpg --list-secret-keys --keyid-format LONG
```

Export your personal key to a file called `personal.asc`. Then send this file to
your other computer.

```
gpg --export-secret-keys --armor --output "personal.asc"
```

Import the personal key onto your work computer.

```
gpg --import "personal.asc"
```

Sign the new key to validate it.

```
gpg --sign-key <keyid>
```

Repeat the above steps to migrate keys between machines at your leisure.

### Install Neovim

Neovim is the "next gen Vim". The main goals of creating this fork of Vim were
to refactor the code to improve maintenance; implement new advanced features;
expose a better, more powerful plugin system; and have a more open development
model, where contributions are more easily accepted. So far, they've done a great
job, and many plugins have come out that make active use of the new features,
particularly the asynchronous nature of Neovim. Keep in mind that Neovim is still
very new (v0.1.7). While it is being actively worked on, it may break at times.

```
brew install neovim/neovim/neovim
```

There are reported issues with some system commands (e.g. `pbcopy`) when running
a tmux session. It is recommended to also install this wrapper program to allow
for tmux and the OS to play nicely together. [Read more here](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/blob/master/README.md).

```
brew install reattach-to-user-namespace
```

Some Neovim plugins are written in or have build setups in Python, so we need to
install python.

```
brew install python3
```

Then enable the neovim Python3 interface with pip:

```
pip3 install neovim
```

### Install Vim (optional)

At this point, I have fully transfered all of my editing tools over to Neovim
and thus don't really need Vim around anymore. If you'd like it as a fallback
though, here is the best way to get it.

macOS ships with Vim by default. However, just like Zsh, it is an outdated
version.

```
brew install vim
```

Running `which vim` should now return `/usr/local/bin/vim`

_**NOTE**: If you're running macOS 10.11 (El Capitan) and are having issues with
moving the system `vim`, please see this [Stack Exchange answer on the issue](http://apple.stackexchange.com/a/202969)._

## <a name="dotfiles"></a>Dotfiles Installation

### Main Dotfiles

Clone the repo

```
git clone --recursive https://github.com/indiesquidge/squidgefiles.git ~/.dotfiles
```

Symlinking is handled via [Dotbot](https://github.com/anishathalye/dotbot):

```
cd ~/.dotfiles
./install
```

### Vim Plug

Vim Plugins are handled via [Plug](https://github.com/junegunn/vim-plug),
which can be installed with this command

```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

After which, the repository plugins can be installed.

```
vim +PlugInstall +qall
```

### Prezto

[Prezto](https://github.com/indiesquidge/prezto) is a configuration framework
for Zsh. It provides nice aliases, functions, auto-completions, and pretty
prompt themes.

Clone the repo into ~/.zprezto

```
git clone --recursive https://github.com/indiesquidge/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Run the following in zsh to have prezto configure its preferences

```
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

It will probably return `ln: /Users/<username>/.zshrc: File exists`. This is
fine. We have our own `.zshrc` file that we want to use anyway.

Lastly, let's get rid of the login prompt seen when a new terminal tab or window
is opened.

```
touch ~/.hushlogin
```

Opening a new terminal tab should show just your prompt. Nice and clean :sparkles:

### Tmux (optional)

[Tmux](https://tmux.github.io/) is a terminal multiplexer, which is a fancy way
of saying you can run multiple shell instances on different "panes" within the
same terminal window, as well as create tabs. Some users prefer this over their
terminal's window and tab features because it provides more granular control.
However, most modern terminals (as well as Vim buffers) can perform window and
pane splitting.

```
brew install tmux
```

You should now be able to run `tmux` to enter a new session. The Tmux leader is
set to `<C-a>`. A few basic commands to make sure it's working could be `<C-a> s`
for horizontal splits and `<C-a> v` for vertical splits. For a full list of Tmux
commands, see [this cheat sheet](https://gist.github.com/MohamedAlaa/2961058), or check out the tmux config file
`vim ~/.tmux.conf`.

## <a name="configuration"></a>Configuration & Preferences

### Fonts & Colors

#### Fonts

Main Fonts: `OperatorMono-XLight*.otf`
Powerline symbols: `PowerlineSymbols-Powerline.otf`

Install the included fonts:

```
cp ~/.dotfiles/config/fonts/* ~/Library/Fonts
```

To use the Operator Mono font, go to iTerm > Preferences > Profiles > Text and
choose Operator Mono XLight.

#### Colors

Vim ships from this repo already using seoul256. To use the same font within the
iTerm2 app, do the following: \* Under iTerm > Preferences > Profiles > Colors,
choose "Load Presets... > Import", press ⇧⌘g (shift-cmd-g) and type in the file
path for seoul256 colors `~/.dotfiles/config/`, and select `seoul256.itermcolors`.

Now the color scheme should be coherent and seamless across both the editor and
the terminal.

## <a name="iterm-preferences"></a>iTerm2 Preferences

Open up preferences (iTerm > Preferences _-or-_ ⌘,)

* Under General,
  * Uncheck "Native full screen windows" to allow full screen without window switching
* Under Profile,
  * Under General, fill in "tmux" for "Send text at start" to start tmux for new windows automatically
  * Under Colors, check "Smart Cursor Color"
  * Under Text
    * check "Italic text allowed" under Text Rendering
    * check "Draw bold text in bold font" under Text Rendering
    * check "Anti-aliased" under Font
    * uncheck everything else
  * Under Window
    * Set the settings for "Style" to Fullscreen
  * Under Terminal
    * Under Terminal Emulation, choose "xterm-256color-italic" for "Report Terminal Type" (manually type in if needed)
    * Under Notifications, check "Silence bell"; uncheck everything else
* Under Keys
  * Enable system-wide hotkey to whatever you like. Right now I'm digging `^e`
    since it's on home row (`caps lock` mapped to `control`)
  * Under "Key Mappings", add the following, all of which should have an action of ignore: ⌘t, ⌘r, ⌘w

_**NOTE**: load and compile the "xterm-256color-italic" file for terminal use, run:_

```
tic ~/.dotfiles/config/iterm2/xterm-256color-italic.terminfo
```

## <a name="packages"></a>Random Useful Packages

* `brew install ag` - better faster stronger `grep` (e.g. `ag "daft punk" some/file/path`)
* `brew install node` - NodeJS
* `brew install yarn` - JS package manager
* `brew install hub` - GitHub CLI commands (e.g. `hub create`, `hub pull-request`)
* `brew install tree` - CLI directory structure (e.g. `tree ~/Downloads`)
* `brew install httpie` - CLI HTTP client (e.g. `http swapi.co/api/planets/1/`)
* `brew install jq` - `sed` for JSON data (e.g. `http swapi.co/api/planets/1/ | jq '.'`)
* `brew install youtube-dl` - download YouTube videos from the CLI (e.g. `youtube-dl https://youtu.be/dQw4w9WgXcQ`)
  * _**NOTE**: `ffmpeg` or `avconv` needed to merge audio and video for downloaded content_
* `brew install homebrew/dupes/less` - upgraded version of `less` in order to [display emoji in git logs!](http://www.recursion.org/2016/6/19/displaying-emoji-in-git-log)
* `brew install gpg` - gpg keyring manager
