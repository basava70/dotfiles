# Turn off screen going black after 10 seconds of inactivity
# xset s off && xset -dpms

# fastfetch 

# Initialize Zsh completion system
autoload -Uz compinit
zstyle ':completion:*' rehash true
compinit -C

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

# Remove nvim cache
alias remove_nvim_cache='rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim'

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

# cuda relatted stuff
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# Ensure zsh-autosuggestions uses persistent history
ZSH_AUTOSUGGEST_STRATEGY=(history)

# fzf key bindings and completion (if installed)
[ -f "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh"
# For Arch Linux (system-wide plugin location)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# For Homebrew (macOS)
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then 
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then  
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
fi

# For Homebrew (macOS)
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# For Arch Linux (system-wide plugin location)
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Accept autosuggestions with Ctrl+L
bindkey '^y' autosuggest-accept

# Syntax highlighting (keep this at the very end)
# macOS (Homebrew)
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Arch Linux or others (system-wide path)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

export PATH="$HOME/.npm-global/bin:$PATH"
