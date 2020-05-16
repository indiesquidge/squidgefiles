```
  ____              _     _             __ _ _
 / ___|  __ _ _   _(_) __| | __ _  ___ / _(_) | ___  ___
 \___ \ / _` | | | | |/ _` |/ _` |/ _ \ |_| | |/ _ \/ __|
  ___) | (_| | |_| | | (_| | (_| |  __/  _| | |  __/\__ \
 |____/ \__, |\__,_|_|\__,_|\__, |\___|_| |_|_|\___||___/
           |_|              |___/

Opinionated dotfiles for Zsh, Vim, and Tmux
```

![](http://i.imgur.com/9uXFru1.jpg)

# Table of Contents

* [Dependencies](#dependencies)
* [Dotfile Installation](#dotfiles)
* [Configuration & Preferences](#configuration)
* [iTerm2 Preferences](#iterm-preferences)
* [Useful Packages](#packages)

---

## <a name="dependencies"></a>Dependencies

### Install Xcode Command Line Tools

```
xcode-select --install
```

### Download iTerm2

Download latest version from here: https://www.iterm2.com/downloads.html

### Install Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install Git

```
brew install git
```

Personal configuration of git

```
git config --global user.name "Austin Wood"
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore
```

As a matter of personal taste, I prefer to [hide my email address][1] on GitHub.
I also like to work with different email addresses for different Git repositories,
generally to separate work and personal projects.

As of Git 2.8, I can tell Git not to guess, but rather to insist that I set
`user.name` and `user.email` explicitly before it will let me commit to a new
repository. To ensure this happens, I set the following global config flag.

```
git config --global user.useconfigonly true
```

### Connecting to GitHub with SSH

Follow [these articles][2] to be learn how to authenticate with GitHub from Git. This
will grant you the action to clone using SSH (more secure), and also make it so that
you don't have to enter in your GitHub username and password every time you e.g. push
to a remote branch.

Note to self: I keep my private SSH keys on a separate drive.

### Signing commits

Git allows you to sign your commits. To get started, follow the [related articles][3].

Install GnuPG to manage keyring

```
brew install gpg
```

If you have existing keys, follow this page to [import and validate your keys][4].

Note to self: I keep my private GPG key on a separate drive.

Then you can set your git config to require a signature using GPG

```
git config --global commit.gpgsign true
git config --global gpg.program /usr/local/bin/gpg
git config --global user.signingkey YOUR_GPG_KEY_ID
```

[See this page to find your key ID][10].

You will want to [trust your signing key][11] so that it shows up as a valid
signature in git-log.

Now when you make some changes in a git directory, committing those changes will
open an in-terminal dialog for you to enter your GPG key password that you set
up when following the GitHub tutorials linked to above.

#### Managing multiple keys

_**NOTE**: if you plan on using different GPG keys associated with work and
personal emails, but have instantiated the keys on different computers, you can
follow these steps to get external keys onto another machine._

You can use this command to see which keys you currently have on your machine

```
gpg --list-secret-keys --keyid-format LONG
```

Export your personal secret key to a file called `personal.asc`. Then send this file
to your other computer.

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

## <a name="dotfiles"></a>Dotfiles Installation

### Main Dotfiles

Clone the repo

```
git clone git@github.com:indiesquidge/squidgefiles.git ~/.dotfiles
```

Symlinking is handled via [Dotbot](https://github.com/anishathalye/dotbot):

```
cd ~/.dotfiles
./install
```

### Vim Plug

Vim Plugins are handled via [Plug][5], install Plug with this command.

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then install the dotfile plugins.

```
vim +PlugInstall +qall
```

### Prezto

[Prezto][6] is a configuration framework for zsh. It provides nice aliases,
auto-completions, and pretty prompt themes.

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

It will probably return something like `.zshrc: File exists`. This is fine.
We have our own `.zshrc` file that we want to use anyway.

Lastly, let's get rid of the login prompt seen when a new terminal tab or window
is opened.

```
touch ~/.hushlogin
```

Opening a new terminal tab should show just your prompt. Nice and clean :sparkles:

### Tmux

[Tmux][7] is a terminal multiplexer, which is a fancy way of saying you can run
multiple shell instances on different "panes" within the same terminal window, as
well as create tabs. Some users prefer this over their terminal's window and tab
features because it provides more granular control.  However, most modern terminals
(as well as Vim buffers) can perform window and pane splitting without Tmux.

```
brew install tmux
```

There are reported issues with some system commands (e.g. `pbcopy`) when running
a tmux session. We need to also install this wrapper program to allow for tmux and
the OS to play nicely together. [Read more here][9].

```
brew install reattach-to-user-namespace
```

If you'd like to use italic fonts in your terminal within tmux, load  the
"xterm-256color-italic" file for terminal use:

```
tic ~/.dotfiles/config/iterm2/xterm-256color-italic.terminfo
```

You should now be able to run `tmux` to enter a new session. The Tmux leader is
set to `<C-a>`. A few basic commands to make sure it's working could be `<C-a> s`
for horizontal splits and `<C-a> v` for vertical splits. For a full list of Tmux
commands, see this [cheat sheet][8], or check out the tmux config file `vim ~/.tmux.conf`.

## <a name="configuration"></a>Configuration & Preferences

### Fonts & Colors

#### Fonts

_**NOTE**: The following Fonts section is based on fonts I have personally._

Main Fonts: `DankMono-*.otf`
Powerline symbols: `PowerlineSymbols-Powerline.otf`

Install the fonts:

```
cp ~/Dropbox/fonts/DankMono* ~/Library/Fonts
cp ~/Dropbox/fonts/PowerlineSymbols* ~/Library/Fonts
```

To use the Dank Mono font, go to iTerm > Preferences > Profiles > Text and choose
14pt Dank Mono Regular. Check use ligatures, anti-aliased, and use a different
font for non-ASCII text. Choose PowerlineSymbols 14pt for non-ASCII font.

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
  * Under Window, uncheck "Native full screen windows" to allow full screen without window switching
* Under Profiles,
  * Under General, fill in "tmux" for "Send text at start" to start tmux for new windows automatically
  * Under Colors, check "Smart Cursor Color"
  * Under Text
    * check "Italic text" and "Draw bold text in bold font"
    * check "Anti-aliased" and "Use ligatures" under Font
  * Under Window
    * Set the settings for "Style" to Fullscreen
  * Under Terminal
    * Under Terminal Emulation, choose "xterm-256color-italic" for "Report Terminal Type" (manually type in if needed)
    * Under the Notifications heading, check "Silence bell", uncheck everything else
* Under Keys
  * Under Hotkey, enable system-wide hotkey to whatever you like. Right now I'm digging `^e`
    since it's on home row (`caps lock` mapped to `control`)
  * Under Key Bindings, add the following, all of which should have an action of ignore: ⌘n, ⌘t, ⌘r, ⌘w, ⌘k

## <a name="packages"></a>Useful Packages

* `brew install rg` - better faster stronger `grep` (e.g. `rg "daft punk" some/file/path`)
* `brew install node` - NodeJS
* `brew install hub` - GitHub CLI commands (e.g. `hub create`, `hub pull-request`)
* `brew install tree` - CLI directory structure (e.g. `tree ~/Downloads`)
* `brew install httpie` - CLI HTTP client (e.g. `http swapi.co/api/planets/1/`)
* `brew install jq` - `sed` for JSON data (e.g. `http swapi.co/api/planets/1/ | jq '.'`)
* `brew install youtube-dl` - download YouTube videos from the CLI (e.g. `youtube-dl https://youtu.be/dQw4w9WgXcQ`)
  * _**NOTE**: `ffmpeg` or `avconv` needed to merge audio and video for downloaded content_
* `brew install homebrew/dupes/less` - upgraded version of `less` in order to [display emoji in git logs!](http://www.recursion.org/2016/6/19/displaying-emoji-in-git-log)

[1]: https://help.github.com/articles/keeping-your-email-address-private/
[2]: https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
[3]: https://help.github.com/articles/signing-commits-using-gpg/
[4]: https://www.gnupg.org/gph/en/manual/x56.html#AEN83
[5]: https://github.com/junegunn/vim-plug
[6]: https://github.com/indiesquidge/prezto
[7]: https://tmux.github.io/
[8]: https://gist.github.com/MohamedAlaa/2961058
[9]: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/blob/master/README.md
[10]: https://help.github.com/en/enterprise/2.14/user/articles/telling-git-about-your-signing-key
[11]: https://www.gnupg.org/gph/en/manual/x334.html#AEN345
