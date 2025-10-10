# Set vim alias to nvim if nvim is installed
if command -v nvim  >/dev/null 2&>1; then
    alias vim='nvim'
fi

# HOMEBREW
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

# ASDF setup
export ASDF_DATA_DIR="${HOME}/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Enable ASDF autocompletion
fpath=($HOME/.asdf_data/completions $fpath)
autoload -Uz compinit && compinit

# Pure
ZSH_THEME="" # Override defailt oh-my-zsh theme
fpath+=$(brew --prefix)/share/zsh-functions
autoload -Uz promptinit
promptinit
prompt pure

# Rebar3
export PATH=$HOME/.cache/rebar3/bin:$PATH

# Livebook
export ELIXIR_ERL_OPTION="-epmd_module Elixir.Livebook.EPMD"

# Erlang installation thourhg ASDF
export KERL_CONFIGURE_DISABLE_APPLICATIONS="odbc megaco"
 # `-Wno-error=implicit-function-declaration`: I have no idea if we should use this: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-function-declaration
 # `-O2` # This seems fine, though the `kerl` docs use level 3 which is interesting: https://github.com/kerl/kerl#using-shell-export-command-in-kerlrc
 # `-g` # This includes debug information, which I prefer!
 # `-fno-stack-check`: I think this is now the default on macOS? https://github.com/search?q=repo%3Aerlang%2Fotp%20no-stack-check&type=code
export CFLAGS="-Wno-error=implicit-function-declaration -O2 -g -fno-stack-check"
export KERL_BUILD_DOCS="yes"
export KERL_DOC_TARGETS="man html chunks"
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"

# Python multitreading
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
