#!/bin/sh
#Program:
#    This script been use open or close Port 139 or 445
# Histroy :
# 2016/10/24 wikinee First realse
# DOS Support Team <support_os@sari.ac.cn>

export PATH;

smbPasswd="/etc/samba/smbpasswd"

if [ -f "$smbPasswd" ]; then
    echo "ATTENTION: You Have Add Samba User Already!"
fi

#read -p "Please Input you password for Samba account?" passwd
user=$1
if [ -z "$1" ]; then
    user="root"
fi

passwd=$2
if [ -z "$2" ]; then
    passwd="123456"
fi

sudo touch /etc/samba/smbpasswd

echo "INFO: USER $user password $passwd"

(echo $passwd;echo $passwd) | sudo smbpasswd -a $user -s

sudo smbpasswd -e $user

sudo service smbd restart