
# Editor
export EDITOR=nvim

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt inc_append_history share_history hist_ignore_all_dups hist_reduce_blanks hist_ignore_space

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# fzf theme
# [ -f "$HOME/dotfiles/Extras/fzf/dist/tokyonight-night.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/tokyonight-night.sh"
[ -f "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh"

# Keybinds
bindkey '^y' autosuggest-accept
