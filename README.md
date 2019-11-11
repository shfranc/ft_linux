# ft_linux
Personal linux distribution from scratch

## Setup
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


## Download Packages
1. as *root*, sinstall packages: run `install_packages.sh`
2. as *root*, check packages: run `check_packages.sh`
3. prepare tools directory for later: `prepare_tools.sh`

## User lfs & environment
1. create a less priviledged user lfs: `user_lfs.sh`
2. switch user: `su - lfs`
3. config the environment for *lfs*, run `user_env.sh`
4. `source ~/.bash_profile`

## Install packages
- tar xvf <package>
- follow instructions
- rm -rf <extracted folder>

SBU ~ 3 min

| Package | SBU | Status |
| --- | --- | --- |
| binutils-2.32 | 1 | ok |
| gcc-9.2.0 | 12 | make |
| linux-5.2.8 |  |  |
| glibc-2.30 |  |  |
| Libstdc++ |  |  |

------------------

## Mics

### Resume work:
- before ending a work session: copy the entire folder of the VM in the cloud/usb key.
- download it back before starting Virtual Box.
- partition lfs will not be mounted:
```bash
fdisk -l # to check the name of the partition
mount -v -t ext4 $partition $LFS
```
- check that the user *lfs* exists and that the permissions for the folders /mnt/sources or /mnt/tools are correct.
