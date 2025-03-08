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
#
# Ensure persistent history across reboots
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Append history instead of overwriting it
setopt inc_append_history
setopt share_history

# Remove duplicate entries and optimize history
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_reduce_blanks
setopt hist_ignore_space  # Ignore commands that start with a space

# Ensure zsh-autosuggestions uses persistent history
ZSH_AUTOSUGGEST_STRATEGY=(history)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Accept autosuggestions with Ctrl+L
bindkey '^y' autosuggest-accept


# Syntax highlighting (keep this at the very end)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH=$HOME/dotfiles/code:$PATH
