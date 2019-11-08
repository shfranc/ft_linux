set -x

pushd $LFS/sources
wget http://fr.linuxfromscratch.org/view/lfs-systemd-stable/md5sums
md5sum -c md5sums
popd
