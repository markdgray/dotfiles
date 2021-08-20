# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export GOPATH=`go env GOPATH`
export PATH=/usr/local/go/bin/:$HOME/ddlog/bin:$GOPATH/bin:$PATH

# To enable i-search (ctrl-s)
stty -ixon

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

#export PROMPT_COMMAND="history -a; history -n"
export HISTTIMEFORMAT="%d/%m/%y %T "

source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

export PATH=$PATH:$(go env GOPATH)/bin

review_patchwork() {
	if [ "$#" -ne 2 ]; then
		echo "Usage: command <branch_name> <patchwork series ID>"
		return 1
	fi
	git fetch upstream
	git checkout -b review/$1 upstream/master
	git-pw series apply $2
}

review_github() {
	if [ "$#" -ne 2 ]; then
		echo "Usage: command <branch_name> <pr number>"
		return 1
	fi
	git fetch upstream pull/$2/head:review/$1
	git checkout review/$1
}
alias gh=review_github
alias grev=review_patchwork
alias gpw=review_patchwork
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -s"
alias gca="git commit -s --amend"
alias gfu="git fetch upstream"
alias gl="git log --format=oneline"
alias gd="git diff"
alias gs="git status"
alias gll="git log"
alias glf="git log -1 --pretty=fixes"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gbc="git checkout -b"
alias grhh="git reset --hard HEAD"
alias grum="git reset --hard upstream/master"
alias gsh="git show"
alias gk="git add -u && git commit -s -m \"WIP\""

alias pg="pwclient git-am"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

alias a="ansible -u magray -i ~/code/scripts/hosts"
alias ap="ansible-playbook -u magray -i ~/code/scripts/hosts"
alias ap="ansible-playbook -u root -i ~/code/scripts/hosts"

export PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
alias config='/usr/bin/git --git-dir=/home/magray/.cfg/ --work-tree=/home/magray'
source "$HOME/.cargo/env"
export DDLOG_HOME=$HOME/ddlog
