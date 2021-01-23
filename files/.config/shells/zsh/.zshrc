### PROMPT SETTINGS ###
###############################################################################

# Load and execute the colors function
autoload -U colors
colors

# Enable command expansion inside the prompt
setopt PROMPT_SUBST

# Colours
BLUE="%{$fg[blue]%}"
RED="%{$fg[red]%}"
YELLOW="%{$fg[yellow]%}"
GREEN="%{$fg[green]%}"
MAGENTA="%{$fg[magenta]%}"
WHITE="%{$fg[white]%}"

# Define the width of the charcters so that zsh doesn't get confused
BRANCH='%%{⎇ %%2G%%}'
RIGHT_ARROW='%{❯ %2G%}'
LEFT_ARROW='%{ ❮%2G%}'

# Flush the history memory, and reload before drawing the prompt
HIST_REFRESH='$(fc -AI; fc -RI)'

# Splitting the prompts into sections
if [ $(id -u) != "0" ]; then
  # Normal user prompt colours
  DIR="%B${BLUE}[${YELLOW}%1~"
  GIT='${MAGENTA}$(__git_ps1 ": $BRANCH %s")'
  ARROW="${BLUE}]${RED}${RIGHT_ARROW}%b"
  TIME="%B${RED}${LEFT_ARROW}${BLUE}[${GREEN}%D{%a %d - %I:%M}${BLUE}]%b"
else
  # ROOT user prompt colours
  DIR="%B${RED}[%1~"
  GIT='$(__git_ps1 ": $BRANCH %s")'
  ARROW="]${RIGHT_ARROW}%b"
  TIME="%B${LEFT_ARROW}[%D{%a-%d: %I:%M}]%b"
fi

# The prompts
PROMPT="${HIST_REFRESH}"'${DIR}'"${GIT}"'${ARROW}'
RPROMPT='${TIME}'

### HISTORY SETTINGS ###
###############################################################################

# No. of commands stored in memory
HISTSIZE=1000000

# No. of commands saved to the history file, which is LONG_MAX from limits.h
SAVEHIST=9223372036854775806

# Append to history file instead of overwriting it
setopt APPEND_HISTORY

# Store the time a command was ran and how long it ran for
setopt EXTENDED_HISTORY

# Remove the oldest entry with a duplicate instead of unique entries for memory
setopt HIST_EXPIRE_DUPS_FIRST

# Ignore duplicates of commands already passed
setopt HIST_FIND_NO_DUPS

# Store a command and remove all duplicates stored in the memory
setopt HIST_IGNORE_ALL_DUPS

# Do not store command in memory if it is a duplicate of the previous command
setopt HIST_IGNORE_DUPS

# Do write duplicate entries to the history file
setopt HIST_SAVE_NO_DUPS

# Do not store the `history` (fc -l) commands
setopt HIST_NO_STORE

# Remove unneeded blank spaces from commands before they are stored
setopt HIST_REDUCE_BLANKS

# Do not store lines that start with a space
setopt HIST_IGNORE_SPACE

# Ask you to confirm a command before re-executing it
setopt HIST_VERIFY

# Flush the history memory to a temp file before appending to the histfile
setopt HIST_SAVE_BY_COPY

# Move the zsh history file
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/history/zshhst"

### VI MODE SETTINGS ###
###############################################################################

# Set the default mode as vi-mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# Execute the cursor function
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

### TAB COMPLETION SETTINGS ###
###############################################################################

# Load and execute tab completion
autoload -U compinit
zmodload zsh/complist
compinit

# Include tab completing hidden files
_comp_options+=(globdots)

# Enable using arrows to move in tab completion list
zstyle ':completion:*' menu select

# Allow case-insensitve matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Unique tab completion for aliases
#setopt COMPLETE_ALIASES

### MISC SETTINGS ###
###############################################################################

# Options (un)set inside of functions will be (un)set after a function ends
setopt LOCAL_OPTIONS

# Traps (un)set inside of functions will be (un)set after a function ends
setopt LOCAL_TRAPS

# Keep background process runnig even after exiting the shell
setopt NO_HUP

# Cd into a directry just by typing the directory name
setopt AUTO_CD

# Find the best match to the command you typed and ask if it is what you meant
setopt CORRECT

# The '*' matches files/directories that start with '.'
setopt GLOB_DOTS

# Add additional glob matching functionality
setopt EXTENDED_GLOB

# Load line editing inside a vim buffer
autoload edit-command-line

# Define it as zsh widget
zle -N edit-command-line

# Disable ^S/^Q flow control
stty stop undef

### KEYBINDINGS ###
###############################################################################

# MenuSelect:

  # h, j, k, l: Move through the tab complete menu using vim keys
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history

# Vi Insert:

  # BackSpace: Fix 'BackSpace' not working after leaving vi-cmd
    bindkey -v '^?' backward-delete-char
  # Delete: Have 'Delete' actually 'Delete' characters
    bindkey -v '^[[3~' delete-char
  # Shift + Delete: Have 'Shift + Delete' act like 'Delete'
    bindkey -v '^[[3;2~' delete-char
  # Ctrl+e: Edit current line in a vim buffer
    bindkey -v '^e' edit-command-line
  # down, up: Make 'down', and 'up' prompt you to search through the history
    bindkey -v '^[[B' history-incremental-search-forward
    bindkey -v '^[[A' history-incremental-search-backward

# Vi Command:

  # L, H: Make 'L', and 'H' act like extreme versions of 'l', and 'h'
    bindkey -a 'L' vi-end-of-line
    bindkey -a 'H' vi-beginning-of-line
  # J, K: Make 'J', and 'K' search through the history in a Fish-like manner
    bindkey -a 'J' history-substring-search-down
    bindkey -a 'K' history-substring-search-up
  # down, up: Make 'down', and 'up' prompt you to search through the history
    bindkey -a '^[[B' history-incremental-search-forward
    bindkey -a '^[[A' history-incremental-search-backward
  # U: Make 'U' act the opposite of 'u'
    bindkey -a 'U' redo
  # -: Have '-' accept the current suggestion
    bindkey -a '\-' autosuggest-accept
  # Ctrl+e: Edit current line in a vim buffer
    bindkey -a '^e' edit-command-line
  # Shift + Delete: Have 'Shift + Delete' act like 'Delete'
    bindkey -a '^[[3;2~' delete-char
  # Undbind the stupid key
    bindkey -a ':' undefined-key

# String Substition (works only in text insert mode)

  # Ctrl+a: Terminal Calculator
    bindkey -s '^a' 'bc -l\n'
  # Ctrl+f: Search for a directory using fzf and cd to it
    bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

### SOURCING FILES ###
###############################################################################

# Load Named Directories
source $HOME/.config/shells/zsh/nameddir
# Load File Shortcuts
source $HOME/.config/shells/shared/files
# Load Directory Shortcuts
source $HOME/.config/shells/shared/nameddir
# Load Aliases
source $HOME/.config/shells/shared/aliases
# Git branch and status in prompt
source $HOME/.config/shells/shared/git-prompt.sh
# Fish-style history searching
source $HOME/.config/shells/zsh/plugins/substring/zsh-history-substring-search.zsh
# Fish-style auto-suggestions
source $HOME/.config/shells/zsh/plugins/autosuggestions/zsh-autosuggestions.zsh
# Fish-style syntax highlighting
source $HOME/.config/shells/zsh/plugins/syntax/fast-syntax-highlighting.plugin.zsh
