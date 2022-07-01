**Update the Ubuntu 14 LTS with Latest Patches**

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential -y
sudo apt-get install gksu -y
sudo apt-get install git -y

**NA-UTIL**

sudo apt-get install nautilus-open-terminal -y

**System Monitor (LAN &amp; CPU) (Recommended)**

sudo apt-get install indicator-multiload -y

**WLAN-LAN Speed Monitor**

sudo add-apt-repository ppa:nilarimogard/webupd8 -y
sudo apt-get update -y
sudo apt-get install indicator-netspeed -y

**Wallpaper Installation**

sudo add-apt-repository ppa:peterlevi/ppa
sudo apt-get update
sudo apt-get install variety variety-slideshow

**Install Docker**
sudo apt-get update -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    Software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb\_release -cs) \
   stable

sudo apt-get update -y

sudo apt-get install docker-ce -y

sudo nano /etc/default/docker

DOCKER\_OPTS=&quot;-H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock&quot;

nano ~/.bashrc

export DOCKER\_HOST=localhost:2375

sudo chown ubuntu:ubuntu /var/run/docker.sock

ps aux | grep docker



**Install JDK**

sudo add-apt-repository ppa:webupd8team/java -y

sudo apt-get update -y

sudo apt-get install oracle-java8-installer -y


**Set the Local IP Address**

192.168.1.XXX

**Mount Partition Automatically**

Ref :  [https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup](https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup)

# Back Current Configuration

sudo cp /etc/fstab /etc/fstab.old

# Note the UUID of the partition you want to automount.

sudo blkid

# Edit File

sudo gksu gedit /etc/fstab

# Add New Line

UUID=&quot;88f71a87-245a-4e1e-8fcf-f3c33a8a2b5d&quot; /media/drive1 ext4

**Install Node.js with Node Version Manager**

Ref: [http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#node-version-manager](http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#node-version-manager)

1. **1.**** libssl-dev:**

sudo apt-get install libssl-dev -y

1. **2.**** Install cURL:**

sudo apt-get install curl -y

1. **3.**** Install and update Node Version Manager, or nvm, by using cURL:**

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

source ~/.nvm/nvm.sh

1. **4.**** Compile and install the latest version of Node:**

nvm install 8

1. **5.**** Use version:**

nvm use 8



**Install MongoDB**

Ref: [https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-ubuntu/](https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-ubuntu/)

1. **1.**** Import the public key**

**       ** sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

1. **2.**** Create a list file for MongoDB**

**       ** echo &quot;deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse&quot; | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

1. **3.**** Reload local package database:**

        sudo apt-get update

1. **4.**** Install the MongoDB packages:**

sudo apt-get install -y mongodb-org

1. **5.**** Start MongoDB**

sudo service mongod start

1. **6.**** Stop MongoDB**

**       ** sudo service mongod stop

1. **7.**** Restart MongoDB**

sudo service mongod restart



**Install Packages**

npm install -g nodemon

npm install -g typescript

npm install -g ts-node



**Install Angular CLI**

npm install -g @angular/cli@latest



**Install Chrome**

1. **1.**** Download**

**       ** [https://www.google.com/intl/en-US/chrome/browser/desktop/index.html](https://www.google.com/intl/en-US/chrome/browser/desktop/index.html)

1. **2.**** Open the chrome.deb file with a double click.**

**       ** The TeamViewer installation package will open in the Ubuntu Software Center.

1. **3.**** Click on the Install button.**

**       ** The Authenticate dialog box will open.

1. **4.**** Enter the administrative password.**
2. **5.**** Click on the Authenticate button.**

**Install TeamViewer**

Ref: [https://community.teamviewer.com/t5/Knowledge-Base/Installation-of-TeamViewer-on-a-Ubuntu-system/ta-p/45](https://community.teamviewer.com/t5/Knowledge-Base/Installation-of-TeamViewer-on-a-Ubuntu-system/ta-p/45)

1. **1.**** Download**

[http://www.teamviewer.com/download](http://www.teamviewer.com/download)

1. **2.**** Open the teamviewer\_linux.deb file with a double click.**

The TeamViewer installation package will open in the Ubuntu Software Center.

1. **3.**** Click on the Install button.**

The Authenticate dialog box will open.

1. **4.**** Enter the administrative password.**
2. **5.**** Click on the Authenticate button.**

**Install TimeDoctor**

Ref: [http://support.timedoctor.com/support/solutions/articles/13000009990-how-to-install-time-doctor-in-ubuntu-deb-installer-](http://support.timedoctor.com/support/solutions/articles/13000009990-how-to-install-time-doctor-in-ubuntu-deb-installer-)

1. **1.**** Download**

**       ** [http://www.timedoctor.com/download.html](http://www.timedoctor.com/download.html)

1. **2.**** Open the timedoctor.deb file with a double click.**

The TeamViewer installation package will open in the Ubuntu Software Center.

1. **3.**** Click on the Install button.**

The Authenticate dialog box will open.

1. **4.**** Enter the administrative password.**
2. **5.**** Click on the Authenticate button.**


**Install Slack**

Ref: [https://get.slack.help/hc/en-us/articles/212924728-Slack-for-Linux-beta-](https://get.slack.help/hc/en-us/articles/212924728-Slack-for-Linux-beta-)

1. **1.**** Download**

**       ** [http://www.timedoctor.com/download.html](http://www.timedoctor.com/download.html)

1. **2.**** Open the slack.deb file with a double click.**

The TeamViewer installation package will open in the Ubuntu Software Center.

1. **3.**** Click on the Install button.**

The Authenticate dialog box will open.

1. **4.**** Enter the administrative password.**
2. **5.**** Click on the Authenticate button.**

**Install Visual Code**

Ref: [https://code.visualstudio.com/docs/setup/linux](https://code.visualstudio.com/docs/setup/linux)

1. **1.**** Download**

[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)

1. **2.**** Open the visual\_code.deb file with a double click.**

The TeamViewer installation package will open in the Ubuntu Software Center.

1. **3.**** Click on the Install button.**

The Authenticate dialog box will open.

1. **4.**** Enter the administrative password.**
2. **5.**** Click on the Authenticate button.**



**Install WebStorm**

Ref: https://www.jetbrains.com/help/webstorm/installing-and-launching.html **       **

1. **1.**** Download**

        [https://www.jetbrains.com/webstorm/download/#section=linux](https://www.jetbrains.com/webstorm/download/#section=linux)

1. **2.**** Unpack the WebStorm-\*.tar.gz file**
2. **3.**** Go to: WebStorm-\*/bin directory**
3. **4.**** Run: webstorm.sh file**



**Install RoboMongo  3T**

1. https://robomongo.org/download



**Mozilla Thunderbird**

sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa

sudo apt-get update -y

sudo apt-get upgrade -y



**Remove Webstrome**

rm -rf ~/.WebStorm-145.1616.9/

rm -rf ~/.Webstorm2016.1/

rm -rf ~/.gnome/apps/jetbrains-webstorm.desktop

rm -rf ~/.local/share/applications/jetbrains-webstorm.desktop

**Keyboard Issue for IBus**

Ref : [https://youtrack.jetbrains.com/issue/IDEA-78860](https://youtrack.jetbrains.com/issue/IDEA-78860)

1. 1)Open terminal
2. 2)Command : sudo nano ~/.profile
3. 3)Past end of the file: export IBUS\_ENABLE\_SYNC\_MODE=1
4. 4)Restart PC