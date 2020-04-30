# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi

# -----------------------------
# zplug setting start
# -----------------------------

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# Load theme file
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
zplug "tcnksm/docker-alias", use:zshrc
zplug "k4rthik/git-cal", as:command, frozen:1
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*"

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search"

# git alias
zplug "plugins/git",   from:oh-my-zsh

# A next-generation cd command with an interactive filter
zplug "b4b4r07/enhancd"

# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose


# -----------------------------
# My setting
# -----------------------------

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
if [ -d "$RBENV_ROOT" ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# node
export PATH=$PATH:$HOME/.nodebrew/current/bin
# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:'

#lsコマンド, 補完時の色を変更
autoload -U compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# make path unique
typeset -U path PATH

# --------------
# alias
# --------------
alias ls="ls -GF"
alias gls="gls --color"
# merge済みリモートブランチの最新ログ確認
alias gbrc="git branch -r --list --no-merged | grep -v '*' | xargs -Ibranch git log -1 --pretty=format:'|branch|%an|%ad|%s|' --date=short branch"
# merge済みリモートブランチを削除
alias grp="git remote prune origin"
# git status
alias gs="git status"
# merge済みブランドを削除
alias dmb="git branch --merged | grep -v '*' | xargs -I % git branch -d %"
# 容量の大きいディレクトリを出力
alias show-dir-volume="sudo du -g -x -d 5 / | awk '$1 >= 3{print}'"
# postgresqlを起動
alias psql-start="postgres -D /usr/local/var/postgres"
# Get images 
alias di="docker images"
# Get container process
alias dps="docker ps"
# Get image history
alias dh="docker history"
# Execute interactive cnotainer
alias dex="docker exec -it"
# Delete paused containers
alias dcrm="docker rm $(docker ps -f status=exited -f status=created -f status=dead -f status=paused -q)"
# Delete none images
alias dirm="docker rmi $(docker images -f dangling=true -q)"

# tmux
alias t="tmux"
alias tn="tmux new -s"
alias t-reload="tmux source ~/.tmux.conf"


# --------------
# 履歴関連の設定
# --------------
HISTFILE=~/.zsh_history #履歴ファイルの設定
HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000 # ファイルに何件保存するか
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # histryコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開する
setopt inc_append_history # 履歴をインクリメンタルに追加
