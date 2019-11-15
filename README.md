# ft_linux
Personal linux distribution from scratch. Following the LFS setup with a 5.2.8 kernel.

**Table of Content**
- [Setup Host and Temporary Filesystem](#setup)
- [Build Linux From Scratch](#lfs)
- [Miscellaneous](#misc)


## Setup Host and Temporary Filesystem <div id='setup'/>

### Setup Host VM
1. VM debian 10
	- 10G ext4 /
	- 2G swap
	- 20G ext4 not mounted
2. connect to ssh + scp ft_linux or git clone
3. as *root*, run `prepare_host.sh` and `check_host.sh`
4. `fdisk -l` to see the name of the 20G partition not mounted
5. run `mount_lfs.sh <PARTITION>`
```bash
> df -h
/dev/sda5        19G   45M   18G   1% /mnt/lfs
```


### Download Sources
1. as *root*, sinstall packages: run `install_packages.sh`
2. as *root*, check packages: run `check_packages.sh`
3. prepare tools directory for later: `prepare_tools.sh`

### User lfs & Environment
1. create a less priviledged user lfs: `user_lfs.sh`
2. switch user: `su - lfs`
3. config the environment for *lfs*, run `user_env.sh`
4. `source ~/.bash_profile`

### Install Tools
```bash
tar xvf <package>
# follow instructions
rm -rf <extracted folder>
```

SBU ~ 3 min

| Package | SBU | Install | Tests |
| ---: | --- | :---: | :---: |
| binutils-2.32 - 1st pass | 1 | ok | - |
| gcc-9.2.0 - 1st pass | 12 | ok | - |
| linux-5.2.8 | 0.1  | ok | - |
| glibc-2.30 | 4.8 | ok | ok |
| libstdc++ | 0.5 | ok | - |
| binutils-2.32 - 2nd pass | 1.1 | ok | - |
| linux-5.2.8 | 1.1  | ok | - |
| gcc-9.2.0 - 2nd pass | 15 | ok | ok |
| tcl8.6.9 | 0.9 | ok | ok |
| expect5.45.4 | 0.1 | ok | no |
| dejagnu-1.6.2 | >0.1 | ok | ok |
| m4-1.4.18 | 0.2 | ok | no |
| ncurses-6.1 | 0.6 | ok | no |
| bash-5.0 | 0.4 | ok | no |
| bison-3.4.1 | 0.3 | ok | no |
| bzip2-1.0.8 | >0.1 | ok | ok |
| coreutils-8.31 | 0.8 | ok | no |
| diffutils-3.7 | 0.2 | ok | no |
| file-5.37 | 0.1 | ok | no |
| findutils-4.6.0 | 0.3 | ok | no |
| gawk-5.0.1 | 0.2 | ok | no |
| gettext-0.20.1 | 1.8 | ok | no |
| grep-3.3 | 0.2 | ok | no |
| gzip-1.10 | 0.1 | ok | no |
| make-4.2.1 | 0.1 | ok | no |
| patch-2.7.6 | 0.2 | ok | no |
| perl-5.30.0 | 1.6 | ok| no |
| Python-3.7.4 | 1.4 | ok | no |
| sed-4.7 | 0.2 | ok | no |
| tar-1.32 | 0.3 | ok | no |
| texinfo-6.6 | 0.2 | ok | no |
| util-linux-2.34 | 1 | ok | no |
| xz-5.2.4 | 0.2 | ok | no |


### Back to root
1. change to user *root* and change ownership of `tools` to root.
```bash
root@debian:/mnt# ls -la lfs/
total 16
drwxr-xr-x  4 root root 4096 Nov 11 16:26 .
drwxr-xr-x  3 root root 4096 Nov 11 16:19 ..
drwxrwxrwt  3 lfs  root 4096 Nov 15 14:00 sources
drwxr-xr-x 13 root root 4096 Nov 15 11:12 tools
```

## Build Linux From Scratch <div id='lfs'/>

### Virtual filesystem for the kernel
1. create /dev /proc /sys /run
2. make node /dev/console /dev/null
3. mount /dev # montage en double
4. mount /dev/pts /proc /sys /run

### Chroot
1. chroot: when `/mnt/lfs` become `/`.
"I have no name!" because /etc/passwd is not created yet.
2. Create directories according FHS Filesystem Hierarchy Standard.
```
(lfs chroot) I have no name!:/# ls -lsa
total 76
4 drwxr-xr-x 23    0 0 4096 Nov 15 15:39 .
4 drwxr-xr-x 23    0 0 4096 Nov 15 15:39 ..
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 bin
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 boot
0 drwxr-xr-x 17    0 0 3180 Nov 15 14:27 dev
4 drwxr-xr-x  4    0 0 4096 Nov 15 15:38 etc
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 home
4 drwxr-xr-x  3    0 0 4096 Nov 15 15:38 lib
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:39 lib64
4 drwxr-xr-x  4    0 0 4096 Nov 15 15:38 media
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 mnt
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 opt
0 dr-xr-xr-x 79    0 0    0 Nov 15 14:27 proc
4 drwxr-x---  2    0 0 4096 Nov 15 15:38 root
0 drwxrwxrwt  2    0 0   40 Nov 15 15:15 run
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 sbin
4 drwxrwxrwt  3 1001 0 4096 Nov 15 14:00 sources
4 drwxr-xr-x  2    0 0 4096 Nov 15 15:38 srv
0 dr-xr-xr-x 13    0 0    0 Nov 15 14:27 sys
4 drwxrwxrwt  2    0 0 4096 Nov 15 15:38 tmp
4 drwxr-xr-x 13    0 0 4096 Nov 15 11:12 tools
4 drwxr-xr-x 10    0 0 4096 Nov 15 15:39 usr
4 drwxr-xr-x 10    0 0 4096 Nov 15 15:39 var
```
3. Create essentials files and symlink
4. Start new shell to get rid of "I have no name!"
5. Init journals for login, agetty, et init

### Install packages

| Package | SBU | Install | Tests |
| ---: | --- | :---: | :---: |
| linux-5.2.8 | >0.1 | ok | - |
| man-pages-5.02 | >0.1 | ok | - |
|  |  |  |  |
|  |  |  |  |

------------------

## Miscellaneous <div id='misc'/>

### Resume work:
- before ending a work session: copy the entire folder of the VM in the cloud/usb key.
- download it back before starting Virtual Box.

**HOST**
- partition lfs will not be mounted:
```bash
fdisk -l # to check the name of the partition
mount -v -t ext4 $partition $LFS

ex: mount -v -t ext4 /dev/sda5 $LFS
```
- check that the user *lfs* exists and that the permissions for the folders /mnt/sources or /mnt/tools are correct.

**LFS**  
As *root*
1. Mount the FS
    - /dev (6.2.2)
    - /dev/pts /proc /sysfs /run (6.2.3)
2. And then `chroot` (6.4)
