dotfileの管理リポジトリ（主にvim）
====

## Requirement
[macへhomebrewをインストールする](https://brew.sh/index_ja.html)
```
$ brew install tmux
$ brew install zsh
```

## Shell
shellをzshに変更する
```
$ sudo vi /etc/shells
最後の行に以下を追加
/usr/local/bin/zsh

$ chsh -s /usr/local/bin/zsh
```

## Install
```
$ git clone git@github.com:aiki-y/dotfiles.git
$ cd dotfiles
$ bash dotfilesLink.sh
$ bash install.sh
```
vimを開き
```
:NeoBundleInstall
```

## NeoBundleのプラグイン
### tcomment
#### カレント行のコメントをトグルする
ノーマルモードでgcc
#### 選択した部分のコメントをトグルする
ビジュアルモードでgc

### NERDTree
[vim-plugin NERDTree で開発効率をアップする！](http://qiita.com/zwirky/items/0209579a635b4f9c95ee)

## 導入検討中
### unite
ファイラー兼ランチャー
### fugitive
Vim上からGitを操作
