mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget http://fr.linuxfromscratch.org/view/lfs-systemd-stable/wget-list
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
