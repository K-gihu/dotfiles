#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# 个人设置
export PATH=~/.local/bin:$PATH
alias doom='~/.emacs.d/bin/doom'
alias setproxy='export http_proxy=http://localhost:8889; export https_proxy=http://localhost:8889;'
alias unsetproxy='unset http_proxy https_proxy'
alias curlproxy='curl -x http://localhost:8889'
echo "aliased doom, setproxy, unsetproxy, curlpro"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
