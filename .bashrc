. ~/.bashrc

export LH="${XH:-$LH}"
. "$LH/.asshrc" || echo "[assh] file not found"

SUSER=$(echo $USER | awk -F. '{print (NF==2 ? substr($1,1,1)"."substr($2,1,1) : $0)}')
PS1='${debian_chroot:+($debian_chroot)}'
PS1+='\[\033[01;$(if [[ $EUID == 0 ]]; then echo "31"; elif [[ $USER == *-debug ]]; then echo "35"; else echo "32"; fi)m\]${SUSER}\[\033[00m\]'
PS1+='\[\033[01;32m\]@${XORIGIN:-\h}'
PS1+='\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
