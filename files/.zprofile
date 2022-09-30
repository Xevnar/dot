#!/bin/zsh

# Export all variables definded from now on
setopt ALL_EXPORT

# Remove any dirs in "$HOME/.local/bin" from PATH and re-insert them
PATH="${PATH%%:$HOME/.local/bin*}:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

# Defaults
OPENER='opener'
EDITOR='nvim'
BROWSER='brave'
TERM='alacritty'; TERMINAL="$TERM"

# Define the default system user (depends on my machine)
DEFUSER=''

# Define current login time
LOGINTIME="$(date +%s)"

# Source this machines monitor configuration
source "$HOME/.config/monitors/definitions"

### HOME CLEAN-UP ###
###############################################################################

# XDG paths
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
source "$XDG_CONFIG_HOME/user-dirs.dirs"

# config paths
DOTDIR="$HOME/repos/xev/dot/files"
ZDOTDIR="$XDG_CONFIG_HOME/shells/zsh"
BDOTDIR="$XDG_CONFIG_HOME/shells/bash"
INPUTRC="$XDG_CONFIG_HOME/shells/bash/inputrc"
MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME/android"
OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
_JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# data storage paths
XAUTHORITY="$XDG_CONFIG_HOME/Xauthority"
PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
GOPATH="$XDG_DATA_HOME/go"
GNUPGHOME="$XDG_DATA_HOME/gnupg"
GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android/emulator"
CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
CARGO_HOME="$XDG_DATA_HOME/cargo"
RUSTUP_HOME="$XDG_DATA_HOME/rustup"
KONAN_DATA_DIR="$XDG_DATA_HOME/konan"

# history paths
LESSHISTFILE="$XDG_CACHE_HOME/history/less"
MYSQL_HISTFILE="$XDG_CACHE_HOME/history/mysql"
OCTAVE_HISTFILE="$XDG_CACHE_HOME/history/octave"

### MISC SETTINGS ###
###############################################################################

# Less settings
LESS_TERMCAP_mb="$(printf '%b' '[1;33m')"
LESS_TERMCAP_md="$(printf '%b' '[1;31m')"
LESS_TERMCAP_me="$(printf '%b' '[0m')"
LESS_TERMCAP_so="$(printf '%b' '[01;40;33m')"
LESS_TERMCAP_se="$(printf '%b' '[0m')"
LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
LESS_TERMCAP_ue="$(printf '%b' '[0m')"
LESS=-R
LESSOPEN='| /usr/bin/highlight -O ansi %s 2>/dev/null'

# Set the default java home on login
JAVA_HOME='/usr/lib/jvm/default'

# May have to install wmname
AWT_TOOLKIT='MToolkit'

# Improve font rendering of java programs
JDK_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Fix for Java applications in dwm
_JAVA_AWT_WM_NONREPARENTING=1

# Fix `Device Pixel Ratio` inconsistency in alacritty
WINIT_X11_SCALE_FACTOR=1.66

# Stop exporting all variables and functions defined from now on
unsetopt ALL_EXPORT

# Start graphical enviroment on tty1 if not already running.
[[ "$(tty)" = "/dev/tty1"  && -z $(pgrep -u $USER "\bXorg$") ]] && exec startx
