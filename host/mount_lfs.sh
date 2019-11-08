partition="$1"
echo "create fs on partition"
mkfs -v -t ext4 $partition
echo "mount partition at $LFS"
mkdir -p $LFS
mount -v -t ext4 $partition $LFS
