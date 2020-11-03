#!/bin/bash

HOSTNAME=monad
USER=luis

LANG=C perl -i -pe 's/#(en_US.UTF)/$1/' /etc/locale.gen
LANG=C perl -i -pe 's/#(pt_PT.UTF)/$1/' /etc/locale.gen
locale-gen

localectl set-locale LANG=en_US.UTF-8
localectl set-keymap pt-latin1
echo 'KEYMAP=pt-latin1' > /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

echo $HOSTNAME > /etc/hostname

pacman -S sudo git binutils gdisk dialog refind-efi dosfstools mesa linux-firmware amd-ucode xf86-video-amdgpu
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

echo 'options amdgpu si_support=1' > /etc/modprobe.d/amdgpu.conf
echo 'options amdgpu cik_support=1' >> /etc/modprobe.d/amdgpu.conf

echo '[Match]
Name=en*

[Network]
DHCP=true' > /etc/systemd/network/wired.network

systemctl enable systemd-networkd
systemctl start systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-resolved

echo "run: 'fatlabel /dev/<sd>1 ArchLinux'"

