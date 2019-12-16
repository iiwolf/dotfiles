# ~/.bashrc: executed by bash(1) for non-login shells
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# build and run osg project
function bnr(){

    cd /projects/osgsharedvector/build
    make
    if [[ $? == 0 ]]; then
        ./osgsharedvector
    fi
}

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export HOME="$HOME"
export PROJECTS=$HOME/projects
export DOTFILES=$HOME/dotfiles
export BINPATH=$DOTFILES/bin
export PATH=$PATH:$BINPATH # custom bin

## Aliases, Misc. Defaults ##
alias slack='slack-term --config /home/ijw/snap/slack-term/current/slack-term.json'

# emacs aliases
alias em='emacs -nw'
alias emz='emacs -nw ~/.zshrc'
alias emb='emacs -nw ~/.bashrc'
alias cz='code ~/.zshrc'
alias sz='source ~/.zshrc'

# git aliases
alias gdm='git diff master'
alias gcm='git checkout master'

## Evironment Variables ##
export EDITOR='code'

## HEAT ##
export HEATPATH="$PROJECTS/heat"
export PATH="$PATH:$HEATPATH/build"
export PATH="$PATH:$PROJECTS/heat/tools/bash"
export PYTHONPATH="$PROJECTS/heat/tools/python:$PYTHONPATH"

## PREHEAT ##
export PREHEATPATH="$PROJECTS/preheat"
export PATH="$PATH:$PREHEATPATH/build"

## KOKKOS ##
export OMP_NUM_THREADS=8
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

## OSG ##
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$PROJECTS/OpenSceneGraph/lib"
export PATH="${PATH}:$PROJECTS/OpenSceneGraph/bin"
export OPENTHREADS_INC_DIR="/usr/local/include"

## CUDA ##
export CUDA_INSTALL_PATH="/usr/local/cuda-10.1"
export PATH="$CUDA_INSTALL_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_INSTALL_PATH/lib64:$LD_LIBRARY_PATH"

## FLITES ##
FLITES_VERSION="2.2.0"
export FLT2_DIR="/home/ijw/projects/flites-$FLITES_VERSION"
export FLT2_ARCH="linux_x64_rhel7"
export FLT2_ARCH="linux-x64"
export FLT2_LIBRARY_DIR="/home/ijw/projects/flites-$FLITES_VERSION/binaries/$FLT2_ARCH/lib"
export FLT2_BIN_DIR="/home/ijw/projects/flites-$FLITES_VERSION/binaries/$FLT2_ARCH/bin"
export FLT2_CXX11_ABI="0"
export PLPLOT_LIB="/home/ijw/projects/flites-$FLITES_VERSION/binaries/linux-x64/ext/share/plplot5.13.0"
export __GL_SYNC_TO_VBLANK="0"

## Extensions ## 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. /usr/share/autojump/autojump.sh

