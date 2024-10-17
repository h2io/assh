. ~/.bashrc

export LH="${XH:-$LH}"
. "$LH/.asshrc" || echo "[assh] file not found"
