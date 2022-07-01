#### Install samba and gksu :  (Ubuntu 14)
  	sudo apt-get install samba -y
  	sudo apt-get install gksu -y

#### Edit The Samba Conf File (Ubuntu 14)
    sudo gedit /etc/samba/smb.conf 

#### Add the line to the [global] section of the smb.conf to allow sharing : 
    usershare owner only = false
    name resolve order = bcast host

#### Restart the Samba Server
    sudo restart smbd

#### Install Samba from Ubuntu Software Center