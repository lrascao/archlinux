
# 1. basic setup
#
# $ loadkeys pt-latin1

# 2. partition the disk:
#   https://wiki.archlinux.org/index.php/GPT_fdisk#Create_a_partition_table_and_partitions
#
#   Create 3 partitions:
#       1. /boot EFI system partition, 300M, [ef00]
#       2. /root Linux x86-64 root partition, 35G, [8304]
#       3. /home Linux partition, rest of disk, [8302]
# $ gdisk /dev/<disk>  
#
# $ mkfs.fat /dev/<sd>1
# $ mkfs.ext4 /dev/<sd>2
# $ mkfs.ext4 /dev/<sd>3
#
# $ mount /dev/<sd>2 /mnt
# $ mkdir /mnt/efi
# $ mkdir /mnt/home
# $ mount /dev/<sd>1 /mnt/efi
# $ mount /dev/<sd>3 /home


# 3. fetch bootstrap shell script from github
#
# $ pacstrap /mnt base linux 
# $ genfstab -U /mnt >> /mnt/etc/fstab
# $ arch-chroot /mnt/
# $ bash <(curl -s https://raw.githubusercontent.com/lrascao/archlinux/develop/bootstrap.sh)

bootstrap.sh

nomodeset on kernel options if:
    Fb0: switching to amdgpudrmfb from EFI VGA


## Usage

Run the playbook:

```bash
ansible-playbook --ask-become-pass site.yml
```

## Configure two monitors

$ xrandr --output <output> --rotate left

## Configure UHK
/etc/udev/rules.d/50-uhk60.rules
