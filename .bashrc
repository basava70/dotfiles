# Set default editor
export EDITOR=nvim

# Starship prompt (Bash-compatible)
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init bash)"

# zoxide for smarter cd
eval "$(zoxide init --cmd cd bash)"

# eza aliases
export EZA_CONFIG_DIR="$HOME/.config/eza/"
alias ls='eza --icons -a'
alias lst='eza --icons --tree -T --level 1'
alias lst1='eza --icons --tree -T --level 1'
alias lst2='eza --icons --tree -T --level 2'
alias lst3='eza --icons --tree -T --level 3'
alias lst4='eza --icons --tree -T --level 4'

# Remove nvim cache
alias remove_nvim_cache='rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim'

# Persistent Bash history settings
HISTFILE=~/.bash_history
HISTSIZE=100000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# CUDA-related stuff
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# NPM global packages
export PATH="$HOME/.npm-global/bin:$PATH"

# Custom scripts folder
export PATH=$HOME/dotfiles/code:$PATH

# fzf key bindings and completion (if installed)
[ -f "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh"

# fzf key bindings and completion (if installed)
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

# Enable programmable completion features
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
