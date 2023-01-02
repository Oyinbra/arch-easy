timedatectl set-ntp true
loadkeys us
pacman -Sy reflector archlinux-keyring
reflector --country US --latest 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

lsblk

mkfs.btrfs -f -L ArchLinux /dev/nvme0n1p3
mkfs.vfat -n BOOT /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p2

mount /dev/nvme0n1p3 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@.snapshots

umount -l /mnt

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@ /dev/nvme0n1p3 /mnt

mkdir -p /mnt/{boot/efi,home,var,opt,tmp,srv,.snapshots}

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@var /dev/nvme0n1p3 /mnt/var
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@opt /dev/nvme0n1p3 /mnt/opt
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@tmp /dev/nvme0n1p3 /mnt/tmp
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@srv /dev/nvme0n1p3 /mnt/srv
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots

mount /dev/nvme0n1p1 /mnt/boot/efi

swapon /dev/nvme0n1p2

cd
cp -r arch-easy /mnt

