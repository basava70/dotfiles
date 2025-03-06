# Initialize Zsh completion system
autoload -Uz compinit
zstyle ':completion:*' rehash true
compinit -C

source ~/.xprofile
export EDITOR=nvim


# Point to custom Starship config location
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Initialize Starship prompt
eval "$(starship init zsh)"

# Initialize zoxide
eval "$(zoxide init --cmd cd zsh)"

# Initialize eza
export EZA_CONFIG_DIR="$HOME/.config/eza/"
alias ls='eza --icons -a'
alias lst1='eza --icons --tree -T --level 1'
alias lst2='eza --icons --tree -T --level 2'
alias lst3='eza --icons --tree -T --level 3'
alias lst4='eza --icons --tree -T --level 4'

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Accept autosuggestions with Ctrl+L
bindkey '^y' autosuggest-accept


# Syntax highlighting (keep this at the very end)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
