
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export HOME="$HOME"
export PROJECTS=$HOME/projects
export DOTFILES=$HOME/dotfiles
export BINPATH=$DOTFILES/bin
export PATH=$PATH:$BINPATH # custom bin

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
export HEATPATH=$PROJECTS/heat
export PATH=$PATH:$HEATPATH/build
export PATH=$PATH:$PROJECTS/heat/bin/scripts
export PYTHONPATH=$PROJECTS/heat/bin/pyscripts:$PYTHONPATH

## PREHEAT ##
export PREHEATPATH=$PROJECTS/preheat
export PATH=$PATH:$PREHEATPATH/build

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

# build current project #
function b(){
    if [[ $(pwd) == *"preheat"* ]]; then

        PREHEAT_BUILD_PATH=$PREHEATPATH/build
        jump_back=0
        if [[ $(pwd) != $PREHEAT_BUILD_PATH ]]; then
            jump_back=1
            cd $PREHEAT_BUILD_PATH
        fi

    elif [[ $(pwd) == *"heat" ]]; then
        HEAT_BUILD_PATH=$HEATPATH/build
        jump_back=0
        if [[ $(pwd) != $HEAT_BUILD_PATH ]]; then
            jump_back=1
            cd $HEAT_BUILD_PATH
        fi
    fi

    #make
    make

    if [[ $jump_back == 1 ]]; then
        cd -
    fi
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
        cd ${PROJECTS}/heat-flites
        make

        # if build successful, run
        if [[ $? == 0 ]]; then
            ./heat-flites
        fi

        # return to prev directory if necessary
        if [[ $no_return == 0 ]]; then
            cd -
        fi
        echo "done"

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

alias chmodbin='sudo chmod a+x $BINPATH/*'
alias visit='/usr/local/bin/visit/bin/visit'
alias rgfzf='rg . | fzf'