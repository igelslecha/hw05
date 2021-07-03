#hw05
**Создаю скрипт для Сервера**

**Устанавливаю nfs**

yum install nfs-utils -y

**Включаю необходимые для работы программы**

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap

**Стартую их**

systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

**Создаю папку шары**

mkdir -p /var/share
mkdir -p /var/share/upload
chmod -R 777 /var/share/upload **открыл все права 

**Добавляю сведения о сетевой папке в файл** /etc/exports **Убрал подмену на анонимный вход**

echo "/var/share 192.168.50.11(rw,sync,**root_squash,all_squash**)" >> /etc/exports 

**Перезагружаю сервер nfs, чтобы применить изменения**

exportfs -r

**Подключаю firewall как требуется в задании**

systemctl start firewalld

**Открываю необходимые для работы порты**

firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload


**Скрипт Клиента**
**Устанавливаю nfs**

yum install nfs-utils -y

**Включаю необходимые для работы программы**

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap

**Стартую их**

systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

**Создаю папку для нашей сетевой шары**

mkdir /media/share


**Монтирую шару**

mount -t nfs 192.168.50.10:/var/share /media/share/


**Добавление автомонтирования шары через программу autofs**
**Установка autofs**

yum install -y autofs

**Настройка параметров для папок nfs (время отмонтирования раздела, в случае отсуствия активности на нём с 60 до 3600)**

echo "/nfs /etc/auto.nfs --timeout=3600" >> /etc/auto.master

**Запись для автоматического подъёма шары в файл**

echo "/media/share -rw,soft,intr,rsize=8192,wsize=8192 192.168.50.10:/share" >> /etc/auto.nfs

**Перезапуск autofs для применения изменений**

/etc/init.d/autofs restart

**Создаю тестовый файл в папке предназначенной для записи** 

touch /media/share/upload/naprimer.test
