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

Dotfiles focused heavily on Zsh, Neovim, and Tmux.
```
![](http://i.imgur.com/9uXFru1.jpg)

# Table of Contents

- [Dependencies](#dependencies)
- [Dotfile Installation](#dotfiles)
- [Configuration & Preferences](#configuration)
- [iTerm2 Preferences](#iterm-preferences)
- [Random Useful Packages](#packages)

---

## <a name="dependencies"></a>Dependencies

### Install Xcode Command Line Tools

```
xcode-select --install
```

(Alternatively, if you'd like to use Xcode, you can [download it here](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12).
Open it to agree to the Xcode license, or run

```
sudo xcodebuild -license
```

### Download [iTerm2](https://iterm2.com/nightly/latest)

### Install Homebrew

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
allows you to prove that you're, well, really *you*. To get started, follow the
5-6 related articles [here](https://help.github.com/articles/signing-commits-using-gpg/) that will help you set up a new GPG key, add it to
GitHub, etc.

Then follow [this gist](https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b) to learn how to setup GPG. The only changes I would make
what's provided in that gist is to use `pinentry-curses` in place of
`pinentry-mac` in `gpg-agent.conf`. If you don't have `pinentry`, you can
install it through brew (it's just called `pinentry` on the install).

⚠️ **NOTE**: the contents of `.profile` from the gist mentioned above are already
in place in the `zshrc` of this repository, so no need to worry about that.

Then you can set your git config to require a signature using GPG

```
git config --global commit.gpgsign true
git config --global gpg.program /usr/local/bin/gpg
```

Now when you make some changes in a git directory, committing those changes will
open an in-terminal dialog for you to enter your GPG key password that you set
up when following the GitHub tutorials linked to above.

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

One of the plugins I use, `deoplete`, which is a asynchronous completion framework
for neovim, requires Python3. To install this, run

```
brew install python3
```

Then enable the `neovim` Python3 interface with pip:

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

⚠️ **NOTE**: If you're running macOS 10.11 (El Capitan) and are having issues with
moving the system `vim`, please see this [Stack Exchange answer on the issue](http://apple.stackexchange.com/a/202969).

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

After which, the repository plugins can be installed. By opening a `vim` buffer
and running `:PlugInstall`

### Prezto

[Prezto](https://github.com/indiesquidge/prezto) is a configuration framework
for Zsh. It provides nice aliases, functions, auto-completions, and pretty
prompt themes.

Clone the repo into ~/.zprezto

```
git clone --recursive https://github.com/indiesquidge/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Run the following to have prezto configure its Zsh preferences

```
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

```
touch ~/.hushlogin
```

Opening a new terminal tab should show just your prompt. Nice and clean :sparkles:.

### Tmux & Terminal Battery (optional)
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

⚠️ **NOTE**: if when you run `tmux`, you get an `[exited]` return and do not enter a
Tmux session, installing this will fix the issue.

```
brew install reattach-to-user-namespace
```

You can read more about this issue [here.](http://bit.ly/1HOk6o3)

[Battery](https://github.com/Goles/Battery) is a script to display the battery
status on the tmux status bar.

```
brew tap Goles/battery
brew install battery
```

If you'd like to get rid of the :zap: that appears next to the battery when it's
charging (since its ugly)

```
vim /usr/local/bin/battery
```

Remove just the emoji around line 113. You could add in something else to
signify a charging status. I like to use `++ `.

It would also be wise to remove the `elseif` statement. The first conditional of
the `print_status()` function should now look something like this

```
if ((connected)); then
  GRAPH="++ "
else
  GRAPH=""
fi
```

⚠️ **NOTE**: to save and exit this file, you need to run `:wq!`

## <a name="configuration"></a>Configuration & Preferences

### Fonts & Colors

#### Fonts

Install the three included fonts

```
open ~/.dotfiles/config/*
```

Main Fonts: `OperatorMono-XLight*.otf`
Powerline symbols: `PowerlineSymbols-Powerline.otf`

⚠️ **NOTE**: if the `open` command give you back an error, it is because Tmux,
LSOpenURLsWithRole(), and/or macOS are not playing nicely together. To fix this,
first try exiting out of your Tmux instance (if you're in one) and re-running
the command. If that does not work, you may need a dependency that worked for me
(July 13, 2015).

```
brew install reattach-to-user-namespace
```

The line to use this is already in place in `tmux.conf` on line 29.

To use these fonts, go to iTerm > Preferences > Profiles > Text.
For Font, choose 14pt Operator Mono XLight; select "Anti-aliased"

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
    * Adjust transparency based on personal preference
    * Set the settings for "Style" to Fullscreen
  * Under Terminal
    * Under Terminal Emulation, choose "xterm-256color-italic" for "Report Terminal Type" (manually type in if needed)
    * Under Notifications, check "Silence bell"; uncheck everything else
* Under Keys
  * Enable system-wide hotkey to whatever you like. Right now I'm digging `^e`
    since it's on home row (`caps lock` mapped to `control`)
  * Under "Key Mappings", add the following, all of which should have an action of ignore: ⌘t, ⌘r, ⌘w

⚠️ **NOTE**: load and compile the "xterm-256color-italic" file for terminal use, run
```sh
tic ~/.dotfiles/config/iterm2/xterm-256color-italic.terminfo
```

## <a name="packages"></a>Random Useful Packages

* `brew install ag` - better faster stronger `grep` (e.g. `ag "daft punk" some/file/path`)
* `brew install node` - NodeJS
* `brew install hub` - GitHub CLI commands (e.g. `hub create`, `hub pull-request`)
* `brew install tree` - CLI directory structure (e.g. `tree ~/Downloads`)
* `brew install httpie` - CLI HTTP client (e.g. `http swapi.co/api/planets/1/`)
* `brew install jq` - `sed` for JSON data (e.g. `http swapi.co/api/planets/1/ | jq '.'`)
* `brew install youtube-dl` - YouTube CLI (e.g. `youtube-dl https://youtu.be/dQw4w9WgXcQ`)

## Random Useful Gems

* `gem install octodown` - GitHub CLI markdown previewing (i.e. `octodown README.md`)
