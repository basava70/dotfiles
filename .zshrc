# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

# Plugins (installed via pacman)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Editor
export EDITOR=nvim

# Aliases
alias c='clear'
alias ls='eza --icons -a'
alias lst1='eza --icons -a --tree --level 1'
alias lst2='eza --icons -a --tree --level 2'
alias lst3='eza --icons -a --tree --level 3'
alias lst4='eza --icons -a --tree --level 4'
alias lst5='eza --icons -a --tree --level 5'
alias remove_nvim_cache='rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim'

# Tools
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export EZA_CONFIG_DIR="$HOME/.config/eza/"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# fzf
source <(fzf --zsh)
[ -f "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh"

# Keybinds
bindkey '^y' autosuggest-accept

# PATH
export PATH="$HOME/.local/bin:$PATH"
