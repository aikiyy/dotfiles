# =============================================================================
# .zshrc - zsh configuration file
# =============================================================================

# -----------------------------------------------------------------------------
# tmux 自動起動 (tmuxがインストールされている場合のみ)
# -----------------------------------------------------------------------------
if [ $SHLVL = 1 ] && command -v tmux >/dev/null 2>&1; then
  tmux
fi

# -----------------------------------------------------------------------------
# zplug プラグイン管理
# -----------------------------------------------------------------------------
# zplugのインストールチェック
if [[ ! -d ~/.zplug ]]; then
  echo "Installing zplug..."
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# テーマ設定
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# 構文ハイライト（遅延ロード）
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# コマンドラインツール
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
zplug "k4rthik/git-cal", as:command, frozen:1
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*"

# 履歴検索機能
zplug "zsh-users/zsh-history-substring-search"

# git関連
zplug "plugins/git", from:oh-my-zsh

# ディレクトリ移動強化
zplug "b4b4r07/enhancd"

# 補完機能
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# 色関連
zplug "chrissicool/zsh-256color"

# Docker関連（Dockerがインストールされている場合のみ）
if command -v docker >/dev/null 2>&1; then
  zplug "tcnksm/docker-alias", use:zshrc
fi

# プラグインのインストール確認
if ! zplug check --verbose; then
  printf "Install missing plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# プラグインロード
zplug load

# 補完設定
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'

# -----------------------------------------------------------------------------
# 開発環境設定
# -----------------------------------------------------------------------------

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Python環境 (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]] && command -v pyenv >/dev/null 2>&1; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Ruby環境 (rbenv)
export RBENV_ROOT="$HOME/.rbenv"
if [[ -d "$RBENV_ROOT" ]] && command -v rbenv >/dev/null 2>&1; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Python環境 (rye)
export RYE_ROOT="$HOME/.rye"
if [[ -d "$RYE_ROOT" ]]; then
  source "$RYE_ROOT/env"
fi

# Node.js環境
if [[ -d "$HOME/.nodebrew/current/bin" ]]; then
  export PATH=$PATH:$HOME/.nodebrew/current/bin
fi

# Yarn
if [[ -d "$HOME/.yarn/bin" ]]; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# Google Cloud SDK
GCLOUD_PATH_1="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
GCLOUD_PATH_2="$HOME/Downloads/google-cloud-sdk"

if [[ -f "$GCLOUD_PATH_1/path.zsh.inc" ]]; then
  source "$GCLOUD_PATH_1/path.zsh.inc"
  source "$GCLOUD_PATH_1/completion.zsh.inc"
elif [[ -f "$GCLOUD_PATH_2/path.zsh.inc" ]]; then
  source "$GCLOUD_PATH_2/path.zsh.inc"
  source "$GCLOUD_PATH_2/completion.zsh.inc"
fi

# -----------------------------------------------------------------------------
# 表示設定
# -----------------------------------------------------------------------------

# ls の色設定
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:'

# 補完機能の設定
autoload -U compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''

# PATHの重複を削除
typeset -U path PATH

# -----------------------------------------------------------------------------
# エイリアス設定
# -----------------------------------------------------------------------------

# 基本コマンド
alias ls="ls -GF"
if command -v gls >/dev/null 2>&1; then
  alias gls="gls --color"
fi

# Git関連
alias gs="git status"
alias gbrc="git branch -r --list --no-merged | grep -v '*' | xargs -Ibranch git log -1 --pretty=format:'|branch|%an|%ad|%s|' --date=short branch"
alias grp="git remote prune origin"
alias dmb="git branch --merged | grep -v '*' | xargs -I % git branch -d %"

# システム関連
alias show-dir-volume="sudo du -g -x -d 5 / | awk '\$1 >= 3{print}'"

# PostgreSQL
if command -v postgres >/dev/null 2>&1; then
  alias psql-start="postgres -D /usr/local/var/postgres"
fi

# Docker関連（Dockerがインストールされている場合のみ）
if command -v docker >/dev/null 2>&1; then
  alias di="docker images"
  alias dps="docker ps"
  alias dh="docker history"
  alias dex="docker exec -it"
  alias dcrm="docker rm \$(docker ps -f status=exited -f status=created -f status=dead -f status=paused -q)"
  alias dirm="docker rmi \$(docker images -f dangling=true -q)"
fi

# tmux関連（tmuxがインストールされている場合のみ）
if command -v tmux >/dev/null 2>&1; then
  alias t="tmux"
  alias tn="tmux new -s"
  alias t-reload="tmux source ~/.tmux.conf"
fi

# -----------------------------------------------------------------------------
# 履歴設定
# -----------------------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 履歴の設定オプション
setopt share_history              # 別のターミナルでも履歴を参照
setopt hist_ignore_all_dups       # 重複する履歴を削除
setopt hist_ignore_space          # 先頭スペースのコマンドは保存しない
setopt hist_reduce_blanks         # 余分なスペースを削除
setopt hist_save_no_dups          # historyコマンドは残さない
setopt hist_expire_dups_first     # 古い重複履歴から削除
setopt hist_expand                # 補完時にヒストリを自動展開
setopt inc_append_history         # 履歴をインクリメンタルに追加
