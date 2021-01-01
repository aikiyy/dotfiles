#! /bin/bash
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf ~/dotfiles/.gitignore_global ~/.config/git/ignore
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.jupyter ~/.jupyter
ln -sf ~/dotfiles/.ipython ~/.ipython
ln -sf ~/dotfiles/commands/ide /usr/local/bin/ide
