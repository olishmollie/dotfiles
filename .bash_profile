function emacs() {
    emacsclient -a="" $*
}

# Default Editor
export VISUAL=emacs
export EDITOR=emacs

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

# Configure git awareness
if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; venv_info; $PROMPT_COMMAND"
else
  export PS1="$Red\u$ColorReset \W:> "
fi

export CLICOLOR=1
export GREP_OPTIONS='--color=always'

# Set main go directory
export GOPATH=$HOME/Dev/go

# Source bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Path configuration
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Needed for venv aware prompt
function venv_info() {
  if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
    if [ "$VIRTUAL_ENV" != "" ]; then
      PS1="($(basename "$VIRTUAL_ENV")) $PS1"
    fi
  fi
}
