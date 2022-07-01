### Mount Partition Automatically

#### Back Current Configuration
    sudo cp /etc/fstab /etc/fstab.old

#### Note the UUID of the partition you want to auto-mount.
    sudo blkid

#### Edit File
    sudo gedit /etc/fstab

#### Add New Line
    UUID=88f71a87-245a-4e1e-8fcf-f3c33a8a2b5d /media/drive1 ext4

Ref :  [https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup](https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup)