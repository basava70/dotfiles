# =============================================================================
# Environment
# =============================================================================

export EDITOR=nvim
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export EZA_CONFIG_DIR="$HOME/.config/eza/"

export PATH="$HOME/.local/bin:$PATH"

# =============================================================================
# History
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1100000000
SAVEHIST=1000000000

setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

# =============================================================================
# Options
# =============================================================================

setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt interactivecomments
setopt prompt_subst
setopt pushd_minus

unsetopt flow_control
unsetopt list_beep
unsetopt menu_complete

# =============================================================================
# Completion
# =============================================================================

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache yes

# Case and dash/underscore insensitive matching
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-} r:|[.]=** l:|=*' \
    '+r:?||[-_ \]=* l:?|=[-_ \]' \
    'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-} r:|?=**'

# Prettier completion list
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# =============================================================================
# ZLE
# =============================================================================

zle_highlight=('paste:none')
autoload run-help
unalias run-help 2>/dev/null

# =============================================================================
# Aliases
# =============================================================================

alias c='clear'
alias ls='eza --icons -a'
alias lst1='eza --icons -a --tree --level 1'
alias lst2='eza --icons -a --tree --level 2'
alias lst3='eza --icons -a --tree --level 3'
alias lst4='eza --icons -a --tree --level 4'
alias lst5='eza --icons -a --tree --level 5'
alias remove_nvim_cache='rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim'

# =============================================================================
# Keybinds
# =============================================================================

bindkey '^y' autosuggest-accept

# =============================================================================
# Tools
# =============================================================================

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

# fzf theme
[ -f "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh" ] && source "$HOME/dotfiles/Extras/fzf/dist/rose-pine.sh"

# =============================================================================
# Plugins (sourced last; zsh-syntax-highlighting must be final)
# =============================================================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
