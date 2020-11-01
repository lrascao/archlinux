#!/bin/bash

HOSTNAME=monad
USER=luis

# partition the disk:
#   https://wiki.archlinux.org/index.php/GPT_fdisk#:~:text=GPT%20fdisk%E2%80%94consisting%20of%20the,Record%20(MBR)%20partition%20tables.

pacstrap /mnt base linux
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt/

LANG=C perl -i -pe 's/#(en_US.UTF)/$1/' /etc/locale.gen
LANG=C perl -i -pe 's/#(pt_PT.UTF)/$1/' /etc/locale.gen
locale-gen

localectl set-locale LANG=en_US.UTF-8
localectl set-keymap pt-latin1
echo 'KEYMAP=pt-latin1' > /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

echo $HOSTNAME > /etc/hostname

pacman -S dialog refind-efi
mkdir -p /efi/EFI/Boot
cp /usr/share/refind/refind_x64.efi /efi/EFI/Boot/bootx64.efi
echo 'extra_kernel_version_strings linux,linux-hardened,linux-lts,linux-zen,linux-git;' > /efi/EFI/Boot/refind.conf
echo 'fold_linux_kernels false' >> /efi/EFI/Boot/refind.conf
echo 'default_selection "linux from"' >> /efi/EFI/Boot/refind.conf

useradd -m -G wheel -s /bin/bash $USER
passwd $USER
pacman -S sudo git binutils gdisk dosfstools
perl -i -pe 's/# (%wheel ALL=\(ALL\) ALL)/$1/' /etc/sudoers

