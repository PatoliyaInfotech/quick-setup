#### Install Samba Server
```
sudo apt install tasksel
sudo tasksel install samba-server
```

#### Clean Samba Config
```
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
sudo bash -c 'grep -v -E "^#|^;" /etc/samba/smb.conf_backup | grep . > /etc/samba/smb.conf'
```

#### Add the Samba User & set Password
- `root` should be registered User.
```
sudo smbpasswd -a root
```
- Set the 16 Digit Complex Password

#### Set Access for the Directory
```
sudo nano /etc/samba/smb.conf
```
- Add below line at the end of file
```
[homes]
   comment = Home Directories
   browseable = yes
   read only = no
   create mask = 0700
   directory mask = 0700
   valid users = %S
```

#### Restart Samba Server
```
sudo systemctl restart smbd
```

###### References
```
https://linuxconfig.org/how-to-configure-samba-server-share-on-ubuntu-18-04-bionic-beaver-linux
```