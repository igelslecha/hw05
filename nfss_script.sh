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

#Make special for us nfs--service for firewall
touch /etc/firewalld/services/nfs.xml
echo "<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>NFS
  <description>NFS service
  <port protocol="tcp" port="111"/>
  <port protocol="udp" port="111"/>
  <port protocol="tcp" port="662"/>
  <port protocol="udp" port="662"/>
  <port protocol="tcp" port="892"/>
  <port protocol="udp" port="892"/>
  <port protocol="udp" port="2049"/>
  <port protocol="tcp" port="32803"/>
  <port protocol="udp" port="32803"/>
  <port protocol="tcp" port="38467"/>
  <port protocol="udp" port="38467"/>
  <port protocol="tcp" port="32769"/>
  <port protocol="udp" port="32769"/>
</service>" >> /etc/firewalld/services/nfs.xml
#Open port for firewall in this VM switch off firewall.

firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
