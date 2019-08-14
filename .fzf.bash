# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ijw/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ijw/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ijw/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ijw/.fzf/shell/key-bindings.bash"
