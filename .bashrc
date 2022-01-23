#!/usr/bin/bash


# ---------------------- interactive check for remote shell -------------------

case $- in
    *i*) ;;
      *) return;;
esac

# --------------------------- local utility functions -------------------------

_have()      { type "$1" &>/dev/null; }

# ---------------------------- environment variables --------------------------

export USER="$(whoami)"
export GITUSER="alonsobm"
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"

export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export PICTURES="$HOME/Pictures"
export AUDIOS="$HOME/Audios"
export VIDEOS="$HOME/Videos"
export VIRTUALMACHINES="$HOME/VirtualMachines"
export ZETDIR="$GHREPOS/zettelkasten"

export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

export GOPATH="$HOME/.local/share/go"
export CGO_ENABLED=0

export TERM=xterm-256color
export BLACK="\033[1;30m"
export RED="\033[1;31m"
export GREEN="\033[1;32m"
export ORANGE="\033[1;33m"
export BLUE="\033[1;34m"
export MAGENTA="\033[1;35m"
export CYAN="\033[1;36m"
export LIGHTGRAY="\033[1;37m"
export DEFAULT="\033[1;39m"
export RESET="\033[m"

# ----------------------------------- pager -----------------------------------

#TODO

# ----------------------------------- path ------------------------------------

#TODO

# --------------------------------- dircolors ---------------------------------

#if _have dircolors; then
#  if [[ -r "$HOME/.dircolors" ]]; then
#    eval "$(dircolors -b "$HOME/.dircolors")"
#  else
#    eval "$(dircolors -b)"
#  fi
# fi

# ----------------------------- bash shell options ----------------------------

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# ---------------------------------- history ----------------------------------

export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth

set -o vi
shopt -s histappend

# -------------------------------- smart prompt -------------------------------



parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1 | cut -c 1-17) != "nothing to commit" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

prompt_command() {
  PS1="\[${CYAN}\]┌─\[${ORANGE}\][\u] \[${CYAN}\]in \[${ORANGE}\][\w]\[${CYAN}\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[${MAGENTA}\]\$(parse_git_branch)\[${CYAN}\]\n└─\$ \[$RESET\]"
}

prompt_command
# ---------------------------------- aliases ----------------------------------

alias ls='ls --color=auto'
alias dot='cd $DOTFILES'
alias repos='cd $GHREPOS'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias c='clear'
alias h='history'
alias gs='git status'
alias gl='git log --oneline'
alias ll='ls -alF'
alias l='ls -aF'
alias df='df -h'
alias free='free -h'
alias o='xdg-open'

# --------------------------------- functions ---------------------------------

# TODO

############################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



