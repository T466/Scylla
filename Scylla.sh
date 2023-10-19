#!/bin/bash

if [ ! -e "/opt/SCYLLA" ]; then

mkdir /opt/SCYLLA

else
echo

fi

if [ ! -e "/spool.data.log" ]; then

mkdir /spool.data.log

else
echo

fi

yum install rsync -y


if [ -e "/root/.ssh/id_rsa" ]; then

    echo

else

cd /root; ssh-keygen -t rsa -b 2048
ls -la /root/.ssh/
sleep 5

fi

for (( loop=1;loop>0;loop++));do

clear
echo
echo "FAVOR INSERIR O IP DO SERVIDOR CLIENT"
echo
echo "Exemplo: 192.168.0.99"
read -p "IP : " ip; echo

cd /root/.ssh
ssh-copy-id -i id_rsa root@$ip

ssh root@$ip hostname
ssh root@$ip yum install rsync -y
sleep 6

cd /opt/SCYLLA

echo "#!/bin/bash" >> /opt/SCYLLA/SRV-$ip
echo "mkdir /spool.data.log/SRV-$ip" >> /opt/SCYLLA/SRV-$ip
echo "rsync -aXS root@$ip:/var/log /spool.data.log/SRV-$ip" >> /opt/SCYLLA/SRV-$ip
chmod 775 /opt/SCYLLA/SRV-$ip
echo "*/1 * * * * /opt/SCYLLA/SRV-$ip" >> /var/spool/cron/root

clear
echo "ENTER PARA INSERIR NOVO IP OU CTRL+C PARA SAIR"; echo
read continue

done

