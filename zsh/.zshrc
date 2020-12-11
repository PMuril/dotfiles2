# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


setopt appendhistory extendedglob nomatch
unsetopt autocd beep

bindkey -v
export KEYTIMEOUT=1

# vi mode
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/paolobaldan/.zshrc'

autoload -Uz compinit
compinit

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/shortcutrc" ] && source "$HOME/.config/zsh/shortcutrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"


# setting up custom plugins

# prompt configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#colored output of the LS instruction
export LSCOLORS="EHfxcxdxBxegecabagacad"

#

# Load zsh-syntax-highlighting; should be the last
source /Users/paolobaldan/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
