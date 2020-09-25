
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export HOME=$HOME
export PROJECTS=$HOME/projects
export DOTFILES=$HOME/dotfiles
export BINPATH=$DOTFILES/bin
export PROGRAMS=$HOME/programs
#export PATH=$PATH:$BINPATH:$PROGRAMS/bin

# Misc program paths
export PATH=$PROGRAMS/ParaView-5.7.0-RC1-MPI-Linux-64bit/bin:$PATH
export PATH=$PROGRAMS/gmsh-4.3.0-Linux64/bin:$PATH
export PATH=/usr/local/MATLAB/R2017a/bin/:$PATH

# Project specific
export PATH=$PROJECTS/hyfin/codes/missile-datcom-itar/bin/Linux:$PATH
export PATH=$PROJECTS/meadow/scripts:$PATH
export PATH=$PROJECTS/cws/cws/bin:$PATH

# Python startup
export PYTHONSTARTUP=~/.startup.py
# export PYTHONPATH=$PYTHONPATH:/home/ijw/projects/meadow/meadow-python/rosetta
# export PYTHONPATH=$PYTHONPATH:/home/ijw/programs/ParaView-5.7.0-RC1-MPI-Linux-64bit/lib
# export PYTHONPATH=$PYTHONPATH:/home/ijw/programs/ParaView-5.7.0-RC1-MPI-Linux-64bit/lib/python2.7/site-packages

# load oxide if it's available, if not default to sunaku
ZSH_THEME="theunraveler"

plugins=(git)

source $ZSH/oh-my-zsh.sh

## Keybind overwrites ##
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '\e[3;5~' kill-word
bindkey '^H' backward-kill-word

## Aliases, Misc. Defaults ##

# emacs aliases
alias em='emacs -nw'
alias emz='emacs -nw ~/.zshrc'
alias emb='emacs -nw ~/.bashrc'
alias cz='code ~/.zshrc'
alias sz='source ~/.zshrc'

# git aliases
alias gdm='git diff master'
alias gcm='git checkout master'
alias gdno='git diff --name-only'

# misc alias
alias python='python3'

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
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$FLT2_LIBRARY_DIR"
export PATH="${PATH}:$FLT2_BIN_DIR"

## VTK ##
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/            
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ijw/projects/matlab_c++_interop            

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

# build current project #
function b(){
    
    if [[ $(pwd) == *"preheat"* ]]; then
        PREHEAT_BUILD_PATH=$PREHEATPATH/build
        jump_back=0
        if [[ $(pwd) != $PREHEAT_BUILD_PATH ]]; then
            jump_back=1
            cd $PREHEAT_BUILD_PATH
        fi
    elif [[ $(pwd) == *"flites"* ]]; then
        HEAT_FLITES_BUILD_PATH=$PROJECTS/heat-flites/build
        jump_back=0
        if [[ $(pwd) != $HEAT_FLITES_BUILD_PATH ]]; then
            jump_back=1
            cd $HEAT_FLITES_BUILD_PATH
        fi
    elif [[ $(pwd) == *"heat"* ]]; then
        HEAT_BUILD_PATH=$HEATPATH/build
        jump_back=0
        if [[ $(pwd) != $HEAT_BUILD_PATH ]]; then
            jump_back=1
            cd $HEAT_BUILD_PATH
        fi
    fi

    #make
    make
    result=$?
    if [[ $jump_back == 1 ]]; then
        cd -
    fi
    return $result
}

# build and run current project
function bnr(){

    if [[ $(pwd) == *"osg"* ]]; then
        cd ${PROJECTS}/osgsharedvector/build
        make
        if [[ $? == 0 ]]; then
            ./osgsharedvector
        fi
    elif [[ $(pwd) == *"flites"* ]]; then

        no_return=0
        if [[ $(pwd) == "${PROJECTS}/heat-flites" ]]; then
            no_return=1
        fi
        
        # cd in heat-flights an make
        cd ${PROJECTS}/heat-flites/build
        cmake ..
        make
        res=$?
        cd ${PROJECTS}/heat-flites

        # if build successful, run
        if [[ $res == 0 ]]; then
            ./build/heat-flites $1
        fi

        # return to prev directory if necessary
        if [[ $no_return == 0 ]]; then
            cd -
        fi

    elif [[ $(pwd) == *"heat"* ]]; then

        no_return=0
        if [[ $(pwd) == "${PROJECTS}/heat/build" ]]; then
            no_return=1
        fi

        cd ${PROJECTS}/heat/build
        make

        if [[ $? == 0 ]]; then
            # ./heat-flites
        fi
        if [[ $no_return == 0 ]]; then
            cd -
        fi
    
    fi

}

# create new .sh file $1 in bin
function binscript(){   
    if [[ -f $BINPATH/$1.sh ]]; then
        echo "File $1 already exists!"
        exit 1
    fi

    printf "#!/bin/bash\n# $1 : " > $BINPATH/$1.sh
    code $BINPATH/$1.sh
}

# open file in bin
function codebin(){
    code $BINPATH/$1
}

#ripgrep src directory of current project
function rgsrc(){
    search=$1
    if [[ $(pwd) == *"flites"* ]]; then
        src=/home/ijw/projects/heat-flites/src
    elif [[ $(pwd) == *"preheat"* ]]; then
        src=$PREHEATPATH/src
    elif [[ $(pwd) == *"heat"* ]]; then
        src=$HEATPATH/src    
    fi

    rg $search $src
}

alias chmodbin='sudo chmod a+x $BINPATH/*'
alias visit='/usr/local/bin/visit/bin/visit'
alias rgfzf='rg . | fzf'
alias codetest='code Testing/Temporary/LastTest.log'



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ijw/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ijw/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ijw/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ijw/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Create the alias.
alias dmen='dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'

# conda activate py385
# export PATH=$PATH:/home/ijw/miniconda3/envs/py385/bin
# export PATH=/home/ijw/miniconda3/envs/py385/bin:$PATH
export CONDA_AUTO_ACTIVATE_BASE=false

# Import colorscheme from 'wal'

(cat /home/$(whoami)/.cache/wal/sequences)

# Import the colors.
. "${HOME}/.cache/wal/colors.sh"

# (wal --vte --theme .config/wpg/schemes/_home_ijw__config_wpg_wallpapers_dream_home_jpg_dark_wal__1.1.0.json)