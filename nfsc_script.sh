#Script for Client
#Install utils for nfs
yum install nfs-utils -y
#Switch on installed tools
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
#And start them
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
#Make folder for our net share
mkdir /media/share
#Mount share
mount -t nfs 192.168.50.10:/var/share /media/share/
#Add note to autofs
#Install autofs
yum install -y autofs
#Set autofs
echo "/nfs /etc/auto.nfs --timeout=3600" >> /etc/auto.master
echo "/media/share -rw,soft,intr,rsize=8192,wsize=8192 192.168.50.10:/share" >> /etc/auto.nfs
#Restart autofs
/etc/init.d/autofs restart
#Make file in folder for test 
touch /media/share/upload/naprimer.test