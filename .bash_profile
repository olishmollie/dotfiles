# Default Editor
export VISUAL=vim
export EDITOR=vim
function e {
  code "$1"
}

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

function add_venv_info() {
  if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
    if [ "$VIRTUAL_ENV" != "" ]; then
      PS1="($(basename "$VIRTUAL_ENV")) $PS1"
    fi
  fi
}

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; add_venv_info; $PROMPT_COMMAND"
else
  export PS1="$Red\u$ColorReset \W:> "
fi

# Source bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function mkcd() {
  mkdir "$1"
  cd "$1" || return
}

function restart() {
  exec -l bash
}

function serve() {
  ruby -run -e httpd "$1" -p "$2"
}

function gclonecd() {
  git clone "$1" && (cd "$(basename "$1" .git)" || return)
}

# Venv
function venv() {
  python3 -m venv "$1"
  . "$1/bin/activate"
}

function venvup() {
  . "$1/bin/activate"
}

# Postgres
function pg_start() {
  eval "pg_ctl -D /usr/local/var/postgres start"
}

function pg_stop() {
  eval "pg_ctl -D /usr/local/var/postgres stop"
}

# Colors
export CLICOLOR=1
export GREP_OPTIONS='--color=always'

# Aliases/functions
if type "bundle" > /dev/null 2>&1; then
  alias be='bundle exec'
fi

if type "nvim" > /dev/null 2>&1
then
  alias vim='nvim'
elif type "mvim" > /dev/null 2>&1
then
  alias vim='mvim'
fi

# Set GOPATH and add go bin to PATH
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$PATH

# Add rust executables to path
export PATH="$HOME/.cargo/bin:$PATH"

# Set path for sdkman
export SDKMAN_DIR="/Users/ajbond/.sdkman"
[[ -s "/Users/ajbond/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ajbond/.sdkman/bin/sdkman-init.sh"

# Auto-load rbenv
if type "rbenv" > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Auto-load pyenv
if type "pyenv" > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
