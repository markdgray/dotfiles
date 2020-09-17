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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

export PATH=$PATH:$(go env GOPATH)/bin

alias gcl="git clone"
alias ga="git add"
alias gc="git commit -s"
alias gca="git commit -s --amend"
alias gfu="git fetach upstream"
alias gl="git log"
alias gll="git log --format=oneline"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
alias config='/usr/bin/git --git-dir=/home/magray/.cfg/ --work-tree=/home/magray'
