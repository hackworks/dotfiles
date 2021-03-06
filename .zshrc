# sw:4
set -o autocd on
set -o sharehistory on
set -o shwordsplit on

# Write the completion script to somewhere in your $fpath
if [ ! -f ~/.zsh_functions/_atlas ]; then
    atlas --completion-script-zsh > ~/.zsh_functions/_atlas
fi

HISTFILE=~/.bash_history

# Reuse bash config as far as possible
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

source /Users/dkrishnamurthy/.bashrc

# For Mac using iTerm2
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "\e[3~"  delete-char

# Auto dir stack
DIRSTACKSIZE=8
setopt auto_pushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

# Mimic the same bash command prompt
autoload -U colors && colors
export PS1=$fg_bold[blue]'%~'$reset_color'
$ '

# zsh equivalent for bash command execution hook
precmd() {
    if [ "${VIRTUAL_ENV}" = "" ] ; then
	export PS1="$fg_bold[blue]%~$reset_color
$ "
    else
	export PS1="[$fg_bold[red]py$reset_color] $fg_bold[blue]%~$reset_color
$ "
    fi
    eval "$PROMPT_COMMAND"
}

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
