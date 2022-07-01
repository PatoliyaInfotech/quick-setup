sudo apt-get autoremove -y
sudo du -sh /var/cache/apt
sudo apt-get clean
sudo apt-get autoclean
sudo deborphan | xargs sudo apt-get -y remove --purge
sudo apt-get remove --purge linux-image-X.X.XX-XX-generic
pm2 flush
sudo truncate --size 0 /var/log/nginx/access.log


sudo apt-get install ncdu
sudo ncdu /var/log

sudo find /var/log -type f -delete