# ft_linux
Personal linux distribution from scratch

## Setup
1. VM debian 10
	- 10G ext4 /
	- 2G swap
	- 20G ext4 not mounted
2. connect to ssh + scp ft_linux or git clone
3. run `prepare_host.sh` and `check_host.sh`
4. `fdisk -l` to see the name of the 20G partition not mounted
5. run `mount_lfs.sh <PARTITION>`
```bash
> df -h
/dev/sda5        19G   45M   18G   1% /mnt/lfs
```


## Packages
1. get packages list: `wget http://fr.linuxfromscratch.org/view/lfs-systemd-stable/wget-list`
2. run `install_package.sj`
3. get md5sum list: `wget http://fr.linuxfromscratch.org/view/lfs-systemd-stable/md5sums --output-file $LFS/sources/md5sums`
4. check binaries
```bash
```
