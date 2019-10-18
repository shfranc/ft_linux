PARTITION="$1"
mkfs -v -t ext4 $1
mount -v -t ext4 $1 /mnt/lfs
