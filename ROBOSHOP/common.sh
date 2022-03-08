#!/bin/bash
USER_ID=$(id -u)
if [ USER_ID -ne 0 ]; then
  echo -e\ "\e[31m You should be root user / sudo user to run this script\[0m"
  exit 2
fi

LOG=/tmp/ROBOSHOP.log
rm -f $LOG

STAT_CHECK() {
 if [ $1 -eq 0 ]; then
    echo -e "\e[32m done\e[0m"
 else
    echo -e "\e[31m fail\e[0m"
    exit 1
 fi
}

PRINT() {
    echo -n -e "$1\t\t..."
}
