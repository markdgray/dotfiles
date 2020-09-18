# Instructions
## Add dotfile to be tracked
```
config add ~/vimrc
config commit -s -m "add ~/.vimrc"
config push
```
## Modify dotfile
```
config add ~/.vimrc
config commit
config push
```
## View modified dotfiles
```
config status
```
## View tracked dotfiles
```
config ls-tree master --name-only
```
## Clone to a new machine
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare git@github.com:markdgray/dotfiles.git $HOME/.cfg
config config --local status.showUntrackedFiles no
config checkout
config push --set-upstream origin master
```
# Reference
* https://www.atlassian.com/git/tutorials/dotfiles
