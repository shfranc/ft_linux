#!/bin/bash

update_upgrade() {
	echo "Update and upgrade"
	apt-get -y update && apt-get -y upgrade
}

create_bashrc() {
	echo "Create bashrc"
	cat << EOF > ~/.bashrc

alias l='ls -la'
EOF
}

install_vim() {
	echo "Installing Vim"
	apt-get -y install vim
	vim --version | head -n1
}

install_git() {
	echo "Installing git"
	apt-get -y install git
	git --version | head -n1
}

configure_vim() {
	echo "Configuring Vim..."
	cat << EOF > ~/.vimrc
set nu
set relativenumber
syntax on
set mouse=a
colorscheme industry
set tabstop=4
set shiftwidth=4
EOF
}

link_sh_to_bash() {
	echo "Symlink sh to bash"
	ln -sf /bin/bash /bin/sh
	ls -la /bin/sh
}

install_binaries() {
	echo "Installing binutils coreutils build-essential bison gawk m4 texinfo"
	apt-get -y install \
		binutils \
		coreutils \
		build-essential \
		bison \
		gawk \
		m4 \
		texinfo
}

main() {
	# PERSO
	update_and_upgrade
	create_bashrc
	install_vim
	configure_vim	
	install_git

	# LFS reco
	link_sh_to_bash
	install_binaries
}

main "$@"
