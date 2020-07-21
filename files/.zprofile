#!/bin/sh

export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

export TERMINAL="alacritty"
export BROWSER="brave"
export EDITOR="nvim"

### HOME CLEAN-UP ###
###############################################################################

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# config paths
export DOTDIR="$HOME/docs/dot/files"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/shells/zsh"
export BDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/shells/bash"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shells/bash/inputrc"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"

# data storage paths
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# history paths
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/history/lesshst"

# For Later Referrence
#export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
#export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
#export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
#export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
#export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
#export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
#export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
#export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

### MISC SETTINGS ###
###############################################################################

# Less settings
export LESS_TERMCAP_mb="$(printf '%b' '[1;33m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;40;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS=-R
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Other program settings:
#export DICS="/usr/share/stardict/dic/"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
#export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Have QT use gtk2 theme.
#export QT_QPA_PLATFORMTHEME="gtk2"

# Mozilla smooth scrolling/touchpads.
#export MOZ_USE_XINPUT2="1"

#May have to install wmname
#export AWT_TOOLKIT="MToolkit wmname LG3D"

# Fix for Java applications in dwm
#export _JAVA_AWT_WM_NONREPARENTING=1

# Starting in a graphical enviroment on login
exec startx
