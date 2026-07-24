# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH=~/anaconda3/bin:$PATH
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# bun completions
[ -s "/Users/maxhale/.bun/_bun" ] && source "/Users/maxhale/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"


# Created by `pipx` on 2025-11-17 11:15:26
export PATH="$PATH:/Users/maxhale/.local/bin"
export PATH="/opt/homebrew/Cellar/zigup/2025.05.24/bin:$PATH"

source ~/.nvm/nvm.sh

alias ll='ls -lG'
alias la='ls -la'

export PATH="/Users/maxhale/.duckdb/cli/1.4.4":$PATH

# TMUX

# Create a new detached tmux session with a given tag
alias tnd='tmux new-session -d -s'

# Create a new attached tmux session with a given tag
alias tna='tmux new-session -s'

export PATH="$PATH:/Users/maxhale/.dotnet/tools"

kp() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port>"
    return 1
  fi
  local -a pids
  pids=("${(f)$(lsof -ti tcp:"$1")}")
  if [ ${#pids[@]} -eq 0 ]; then
    echo "No process found on port $1"
  else
    kill -9 "${pids[@]}"
    echo "Killed process(es) ${pids[*]} on port $1"
  fi
}

# Generate a random API-key-strength secret (32 bytes, base64)
alias genkey="openssl rand -base64 32 | tr -d '\n='"
