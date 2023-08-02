#!/bin/bash

HOSTNAME=monad

pacman -Syu --noconfirm perl
LANG=C perl -i -pe 's/#(en_US.UTF)/$1/' /etc/locale.gen
LANG=C perl -i -pe 's/#(pt_PT.UTF)/$1/' /etc/locale.gen
locale-gen

localectl set-locale LANG=en_US.UTF-8
localectl set-keymap pt-latin1
echo 'KEYMAP=pt-latin1' > /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

echo $HOSTNAME > /etc/hostname

hwclock --systohc --utc

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

pacman-key --init

pacman -Syu --noconfirm sudo git binutils gdisk dialog refind dosfstools mesa linux-firmware amd-ucode xf86-video-amdgpu openssh python ansible inetutils which grub efibootmgr os-prober iwd iw wpa_supplicant networkmanager vim

grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p /efi/EFI/Boot
cp /usr/share/refind/refind_x64.efi /efi/EFI/Boot/bootx64.efi
cp -r /usr/share/refind/drivers_x64/ /efi/EFI/Boot/
echo 'extra_kernel_version_strings linux,linux-hardened,linux-lts,linux-zen,linux-git;' > /efi/EFI/Boot/refind.conf
echo 'fold_linux_kernels false' >> /efi/EFI/Boot/refind.conf
echo 'default_selection "linux from"' >> /efi/EFI/Boot/refind.conf
echo 'timeout 5' >> /efi/EFI/Boot/refind.conf

# https://wiki.archlinux.org/title/AMDGPU
echo 'options amdgpu si_support=1' > /etc/modprobe.d/amdgpu.conf
echo 'options amdgpu cik_support=1' >> /etc/modprobe.d/amdgpu.conf

echo 'options radeon si_support=0' > /etc/modprobe.d/radeon.conf
echo 'options radeon cik_support=0' > /etc/modprobe.d/radeon.conf

# regenerate initramfs
# https://wiki.archlinux.org/title/Mkinitcpio#Image_creation_and_activation
mkinitcpio -p linux

echo '[Match]
Name=en*

[Network]
DHCP=true' > /etc/systemd/network/wired.network

echo '[Match]
Name=wl*

[Network]
DHCP=true' > /etc/systemd/network/wireless.network

systemctl enable systemd-networkd
systemctl start systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-resolved

ssh-keygen -A

# disable pc speaker
rmmod pcspkr

echo "Set root password:"
passwd

echo "run: 'fatlabel /dev/<sd>1 ArchLinux'"

