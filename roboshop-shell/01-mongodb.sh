#!/bin/bash

DATE=$(date +%F)
LOGSDIR=/home/centos/shellscript-logs
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


if [ $USERID -ne 0 ]
then
   echo -e "$R ERROR:: please run this script with root access $N"
   exit 1
fi 

VALIDATE(){
    if [ $1 -ne 0 ];
    then 
       echo -e "Installing $2 ... $R FAILURE $N"
       exit 1
    else
       echo -e "Installing $2 ... $G SUCCESS $N"
    fi
 }

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "Copied MongoDB repo into yum.repos.d"

dnf install mongodb-org -y &>> $LOGFILE

VALIDATE $? "Installation of MongoDB"

systemctl enable mongod &>> $LOGFILE

VALIDATE $? "Enabling MongoDB"

systemctl start mongod

VALIDATE $? "Starting MongoDB"

sed -i 's/127.0.0.1/0.0.0.0' /etc/mongod.conf

VALIDATE $? "Edited MongoDB conf"

systemctl restart mongod

VALIDATE $? "Restarting MongoDB"