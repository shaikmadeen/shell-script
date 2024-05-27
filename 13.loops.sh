#!/bin/bash

DATE=$(date +%F)
LOGSDIR=/home/centos/shellscript-logs
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
   echo -e "$R ERROR:: please run this script with root access $N"
   exit 1
fi 

# all args are in $@
for i in $@
do
   yum list installesd $i 
   if [ $? -ne 0 ]
   then 
       echo "$i is not installed, let's install it"
       yum install $i -y 
   else
       echo -e "$Y $i is already installed $N"
   fi 
done    

