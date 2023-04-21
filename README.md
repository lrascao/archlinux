# Archlinux setup

## Download the ISO and flash it to a USB drive

https://archlinux.org/download/

## Bootstrap

```bash
$ loadkeys pt-latin1
```

### Partition the disk:
   https://wiki.archlinux.org/index.php/GPT_fdisk#Create_a_partition_table_and_partitions

   Create 3 partitions:

       1. /boot EFI system partition, 300M, [ef00]
       2. /root Linux x86-64 root partition, 50G, [8304]
       3. /home Linux partition, rest of disk, [8302]

```bash
 $ gdisk /dev/<disk>  

 $ mkfs.fat /dev/<sd>1
 $ mkfs.ext4 /dev/<sd>2
 $ mkfs.ext4 /dev/<sd>3

 $ mount /dev/<sd>2 /mnt
 $ mkdir /mnt/efi
 $ mkdir /mnt/home
 $ mount /dev/<sd>1 /mnt/efi
 $ mount /dev/<sd>3 /mnt/home
```

### Fetch bootstrap shell script from github

```bash
 $ pacstrap /mnt base linux 
 $ genfstab -U /mnt >> /mnt/etc/fstab
 $ arch-chroot /mnt/
 $ bash <(curl -s https://raw.githubusercontent.com/lrascao/archlinux/develop/bootstrap.sh)
 $ fatlabel /dev/<sd>1 Archlinux
 $ reboot
```

## Usage

### Run the playbook:

```bash
$ git clone https://github.com/lrascao/archlinux
$ git submodule update --init --recursive
$ ansible-playbook --ask-become-pass site.yml
```

# Change password for the user
```bash
$ passwd luis
```

## Manual install of some apps

```bash
$ yay -S --mflags --skipinteg spotify
```

## Reboot

```bash
$ sudo reboot now
```

## Configure two monitors

$ xrandr
$ xrandr --output <output> --rotate left

## Configure UHK
/etc/udev/rules.d/50-uhk60.rules

## Todo

* Download peaksea vim theme in vim playbook