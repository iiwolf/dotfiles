# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export HOME="$HOME"
export PROJECTS=$HOME/projects
export DOTFILES=$HOME/dotfiles

# load oxide if it's available, if not default to sunaku
[ -f $ZSH/themes/oxide.zsh-theme ] && ZSH_THEME="oxide" || ZSH_THEME="sunaku"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

## Aliases, Misc. Defaults ##
alias em='emacs -nw'
alias emz='emacs -nw ~/.zshrc'
alias slack='slack-term --config $HOME/snap/slack-term/current/slack-term.json'
export EDITOR='emacs -nw'

## HEAT ##
export HEATPATH=$PROJECTS/heat
export PATH=$PATH:$PROJECTS/heat/bin/scripts
export PYTHONPATH=$PROJECTS/heat/bin/pyscripts:$PYTHONPATH

## KOKKOS ##
export OMP_NUM_THREADS=8
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

## OSG ##
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$PROJECTS/OpenSceneGraph/lib
export PATH=${PATH}:$PROJECTS/OpenSceneGraph/bin
export OPENTHREADS_INC_DIR="/usr/local/include"

## CUDA ##
export CUDA_INSTALL_PATH=/usr/local/cuda-10.1
export PATH=$CUDA_INSTALL_PATH/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_INSTALL_PATH/lib64:$LD_LIBRARY_PATH

## FLITES ##
export FLT2_DIR="$PROJECTS/flites-2.1.4"
export FLT2_BIN_DIR="$PROJECTS/flites-2.1.4/binaries/linux_x64_rhel7/bin"
export FLT2_LIBRARY_DIR="$PROJECTS/flites-2.1.4/binaries/linux_x64_rhel7/lib"
export LD_LIBRARY_PATH="$PROJECTS/flites-2.1.4/binaries/linux_x64_rhel7/lib:$LD_LIBRARY_PATH"
export PATH="$PROJECTS/flites-2.1.4/binaries/linux_x64_rhel7/bin:$PATH"
export MANPATH="$PROJECTS/flites-2.1.4:$MANPATH"

## Extensions ## 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. /usr/share/autojump/autojump.sh

## Functions ##

# create symlink of $1 by moving it to $DOTFILES and pointing back to it
symlink(){
    [ -f $1 ] && echo "Linking $1 to $DOTFILES/$1" || { echo "$1 does not exist" && exit }
    mv $1 $DOTFILES/$1
    ln -s $DOTFILES/$1 $1
}

# remove flites .so because of cuda dependences
move_flites_library(){
    mv $FLT2_LIBRARY_DIR/$1 $FLT2_LIBRARY_DIR/temp/$1
}

#custom script bin path
export PATH=$PATH:$HOME/bin
