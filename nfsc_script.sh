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
mount -t nfs -o vers=3 192.168.50.10:/var/share /media/share/
#Add note to fstab for automount net folder
echo "192.168.50.10:/var/share  /media/share/  nfs   defaults,vers=3 0 0" >> /etc/fstab
#Make file in folder for test 
touch /media/share/upload/naprimer.test