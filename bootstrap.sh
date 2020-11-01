#!/bin/bash

HOSTNAME=monad
USER=luis

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
# $ mount /dev/<sd>1 /mnt/efi


# 3. fetch bootstrap shell script from github
#
# $ pacstrap /mnt base linux git
# $ genfstab -U /mnt >> /mnt/etc/fstab
# $ arch-chroot /mnt/

LANG=C perl -i -pe 's/#(en_US.UTF)/$1/' /etc/locale.gen
LANG=C perl -i -pe 's/#(pt_PT.UTF)/$1/' /etc/locale.gen
locale-gen

localectl set-locale LANG=en_US.UTF-8
localectl set-keymap pt-latin1
echo 'KEYMAP=pt-latin1' > /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

echo $HOSTNAME > /etc/hostname

pacman -S sudo git binutils gdisk dialog refind-efi dosfstools
mkdir -p /efi/EFI/Boot
cp /usr/share/refind/refind_x64.efi /efi/EFI/Boot/bootx64.efi
cp -r /usr/share/refind/drivers_x64/ /efi/EFI/Boot/
echo 'extra_kernel_version_strings linux,linux-hardened,linux-lts,linux-zen,linux-git;' > /efi/EFI/Boot/refind.conf
echo 'fold_linux_kernels false' >> /efi/EFI/Boot/refind.conf
echo 'default_selection "linux from"' >> /efi/EFI/Boot/refind.conf
echo 'timeout 5' >> /efi/EFI/Boot/refind.conf

useradd -m -G wheel -s /bin/bash $USER
passwd $USER
perl -i -pe 's/# (%wheel ALL=\(ALL\) ALL)/$1/' /etc/sudoers

echo "run: 'fatlabel /dev/<sd>1 ArchLinux'"

