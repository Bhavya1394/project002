#!/bin/bash
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
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
    echo -e "\e[33m Check the log file for more details, Log file - $LOG\e[0m"
    exit 1
 fi
}

PRINT() {
  echo -e "\n########################\t$1\t#######################" &>>$LOG
  echo -n -e "$1\t\t..."
}

ADD_APPLICATION_USER() {
  PRINT "Add Roboshop Application User"
  id roboshop &>>$LOG
  if [ $? -ne 0 ]; then
     useradd roboshop &>>$LOG
  fi
  STAT_CHECK $?
}

DOWNLOAD_APP_CODE() {
  PRINT "Download Application Code"
  curl -s -l -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  STAT_CHECK $?

  PRINT "Extract Downloaded Code"
  cd /home/roboshop && unzip -o /tmp/${COMPONENT}.zip &>>$LOG && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT}
  STAT_CHECK $?
}

PERM_FIX() {
  PRINT "Fix Application Permissions"
  chown roboshop:roboshop /home/roboshop -R &>>$LOG
  STAT_CHECK $?
}
SETUP_SYSTEMD() {
  PRINT "Setup systemD file\t"
  sed -i -e "/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" -e "s/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/" -e "s/CARTENDPOINT/cart.roboshop.internal/" -e "s/DBHOST/mysql.roboshop.internal/" /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
  STAT_CHECK $?

  PRINT "Start ${COMPONENT} service\t"
  systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  STAT_CHECK $?
}

NODEJS() {
  PRINT "Install NodeJS\t\t"
  yum install nodejs make gcc-c++ -y &>>$LOG
  STAT_CHECK $?

  ADD_APPLICATION_USER

  DOWNLOAD_APP_CODE

  PRINT "Install NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT} && npm install --unsafe-perm &>>$LOG
  STAT_CHECK $?

  PERM_FIX

  SETUP_SYSTEMD

}

JAVA() {
  PRINT "Install Maven\t\t"
  yum install maven -y &>>$LOG
  STAT_CHECK $?

  ADD_APPLICATION_USER

  DOWNLOAD_APP_CODE

  PRINT "Compile Code\t\t"
  cd /home/roboshop/${COMPONENT} && mvn clean package &>>$LOG && mv target/shipping-1.0.jar shipping.jar
  STAT_CHECK $?

  PERM_FIX

  SETUP_SYSTEMD

}


