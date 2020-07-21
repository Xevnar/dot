### PROMPT SETTINGS ###
###############################################################################

# Attributtes
RESET='\[$(tput sgr0)\]'
BOLD='\[$(tput bold)\]'
DIM='\[$(tput dim)\]'
STNDO='\[$(tput smso)\]'
UNDL='\[$(tput smul)\]'
BLINK='\[$(tput blink)\]'
REV='\[$(tput rev)\]'

# Colours
RED='\[$(tput setaf 1)\]'
GREEN='\[$(tput setaf 2)\]'
YELLOW='\[$(tput setaf 3)\]'
BLUE='\[$(tput setaf 4)\]'
MAGENTA='\[$(tput setaf 5)\]'
CYAN='\[$(tput setaf 6)\]'

# Fix Bash not being able to calculate correct line length due to unicode chars
BRANCH='\['"$(tput sc)"'\]  \['"$(tput rc)"'⎇ \]'
RIGHT_ARROW='\['"$(tput sc)"'\]  \['"$(tput rc)"'❯ \]'
LEFT_ARROW='\['"$(tput sc)"'\]  \['"$(tput rc)"'❮ \]'

# Splitting the prompts into sections
if [ $(id -u) != "0" ]; then
  # Normal user prompt colours
  DIR_SECTION="${BOLD}${BLUE}[${YELLOW}\W"
  GIT_BRANCH="${MAGENTA}\$(__git_ps1 ': ${BRANCH} %s')"
  ARR_SECTION="${BLUE}]${RED}${RIGHT_ARROW}${RESET}${CYAN}"
else
  # ROOT user prompt colours
  DIR_SECTION="${BOLD}${RED}[\W"
  GIT_BRANCH="\$(__git_ps1 ': ${BRANCH} %s')"
  ARR_SECTION="]${RIGHT_ARROW}${RESET}${RED}"
fi

# TODO Have two prompts
LEFT_PROMPT="${DIR_SECTION}${GIT_BRANCH}${ARR_SECTION}"
# RIGHT_PROMPT="${RED}${LEFT_ARROW}${BLUE}[${GREEN} ${BLUE}]${RESET}

# The prompt
PS1="${LEFT_PROMPT}"
PS2="${RED}${RIGHT_ARROW}${YELLOW}"

### HISTORY SETTINGS ###
###############################################################################

# Append to the history file instead of overwriting it
shopt -s histappend

# Ask you to confirm a command before re-executing it
shopt -s histverify

# Number of commands stored in memory when starting bash
HISTSIZE=100000

# Number of commands stored in history file (empty field means unlimited)
HISTFILESIZE=

# Ignore commands that start with space and erase duplicate commads
export HISTCONTROL=ignorespace:erasedups

# List of commands to ignore
export HISTIGNORE="hist:ls:lt:lx:ll:pwd:zsh:clear"

# Add timestamps to the history file
export HISTTIMEFORMAT="%d.%m.%Y %T "

# Move the bash history file
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/history/bashhst"

# Reload the history buffer when hitting enter (stolen from stack exchange)
PROMPT_COMMAND="hist -n; hist -w; hist -c; hist -r; $PROMPT_COMMAND"

### MISC SETTINGS ###
###############################################################################

# Have bash autocomplete commands after commands
complete -c man which

# Have bash autocomplete commands and files after sudo
complete -cf sudo

# Check the window size after each command and if necessary update accordingly
shopt -s checkwinsize

# Cd into a directry just by typing the directory name
shopt -s autocd

# "**" will match all files and zero or more directories and subdirectories.
shopt -s globstar

# Correct minor spelling errors in cd
shopt -s cdspell

# Include dotfiles in wildcard expansion
shopt -s dotglob

# Match case-insensitively in wildcard expansion
shopt -s nocaseglob

# Be able to use variables as directory names
shopt -s cdable_vars

# Correct minor spelling mistakes in directory names after cd
shopt -s cdspell

# Bash doesn't tab complete on an empty line
shopt -s no_empty_cmd_completion

# Keep background process runnig even after exiting the shell
shopt -u huponexit

# Disable ^S/^Q flow control
stty -ixon

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

### SOURCING FILES ###
###############################################################################

source $HOME/.config/shells/shared/aliases
source $HOME/.config/shells/shared/git-prompt.sh
source $HOME/.config/shells/shared/files
source $HOME/.config/shells/shared/nameddir
