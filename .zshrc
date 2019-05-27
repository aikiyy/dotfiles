# -----------------------------
# zplug setting start
# -----------------------------

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

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

# Load theme file
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

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
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# node
export PATH=$PATH:$HOME/.nodebrew/current/bin

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yogai/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yogai/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/yogai/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yogai/google-cloud-sdk/completion.zsh.inc'; fi

#lsコマンド, 補完時の色を変更
autoload -U compinit
compinit

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

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

# --------------
# alias
# --------------
alias ls="ls -GF"
alias gls="gls --color"
# merge済みリモートブランチの最新ログ確認
alias gbrc="git branch -r --list --no-merged | grep -v '*' | xargs -Ibranch git log -1 --pretty=format:'|branch|%an|%ad|%s|' --date=short branch"
# merge済みリモートブランチを削除
alias grp="git remote prune origin"
# 
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
# Execute interactive cnotainer
alias dex="docker exec -it"


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
