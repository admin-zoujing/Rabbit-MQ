#!/bin/bash
#安装centos7.3+Rabbit-MQ脚本

chmod -R 777 /usr/local/src/
#时间时区同步，修改主机名
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ntpdate cn.pool.ntp.org
hwclock --systohc
echo "*/30 * * * * root ntpdate -s 3.cn.poop.ntp.org" >> /etc/crontab

sed -i 's|SELINUX=.*|SELINUX=disabled|' /etc/selinux/config
sed -i 's|SELINUXTYPE=.*|#SELINUXTYPE=targeted|' /etc/selinux/config
sed -i 's|SELINUX=.*|SELINUX=disabled|' /etc/sysconfig/selinux 
sed -i 's|SELINUXTYPE=.*|#SELINUXTYPE=targeted|' /etc/sysconfig/selinux 
setenforce 0 && systemctl stop firewalld && systemctl disable firewalld

rm -rf /var/run/yum.pid 
rm -rf /var/run/yum.pid

yum -y install epel-release.noarch 
yum -y install erlang socat
erl -version
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_12/rabbitmq-server-3.6.12-1.el7.noarch.rpm
chmod 777 rabbitmq-server-3.6.12-1.el7.noarch.rpm
rpm -ivh rabbitmq-server-3.6.12-1.el7.noarch.rpm
systemctl start rabbitmq-server && systemctl enable rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
chown -R rabbitmq.rabbitmq /var/lib/rabbitmq/
rabbitmqctl add_user rabbitmq rabbitmq
rabbitmqctl set_user_tags rabbitmq administrator

#访问http://192.168.8.20:15672


