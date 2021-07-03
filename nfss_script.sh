#Script for Server
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
#Make net folder
mkdir -p /var/share
mkdir -p /var/share/upload
chmod -R 777 /var/share/upload
#Add string about net forlder to file /etc/exports 
echo "/var/share 192.168.50.11(rw,sync,root_squash,all_squash)" >> /etc/exports
#Reboot server nfs
exportfs -r
#Enable firewall
systemctl start firewalld
#Open port for firewall in this VM switch off firewall.
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
