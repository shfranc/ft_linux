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


## Packages
1. as *root*, sinstall packages: run `install_packages.sh`
2. as *root*, check packages: run `check_packages.sh`
3. prepare tools directory for later: `prepare_tools.sh`
4. create a less priviledged user lfs: `user_lfs.sh`
