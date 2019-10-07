#
# kiedtl's ~/.bashrc
# https://github.com/kiedtl/dotfiles
#

export PATH=/home/kiedtl/usr/local/bin:/home/kiedtl/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8

alias git='hub'                           # hub: git + hub = github 8-)
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases


# dylanaraps's mnml prompt.
# https://github.com/dylanaraps/promptless
. '/home/kiedtl/promptless.sh'


# retrieve pywal colorscheme
cat /home/kiedtl/.cache/wal/sequences
