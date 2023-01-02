timedatectl set-ntp true
loadkeys us
# pacman -Sy reflector archlinux-keyring
# reflector --country US --latest 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

lsblk

mkfs.btrfs -f -L ArchLinux /dev/sda3
mkfs.vfat -n BOOT /dev/sda1
mkswap -L swap /dev/sda2

mount /dev/sda3 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@.snapshots

umount -l /mnt

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@ /dev/sda3 /mnt

mkdir -p /mnt/{boot/efi,home,var,opt,tmp,srv,.snapshots}

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@home /dev/sda3 /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@var /dev/sda3 /mnt/var
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@opt /dev/sda3 /mnt/opt
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@tmp /dev/sda3 /mnt/tmp
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@srv /dev/sda3 /mnt/srv
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@.snapshots /dev/sda3 /mnt/.snapshots

mount /dev/sda1 /mnt/boot/efi

swapon /dev/sda2

cd
cp -r arch-easy /mnt

