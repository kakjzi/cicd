#!/bin/bash
BUILD_PATH=$(ls /home/ec2-user/build/*.jar)
JAR_NAME=$(basename $BUILD_PATH)
echo "> build 파일명: $JAR_NAME"

echo "> build 파일 복사"
DEPLOY_PATH=/home/ec2-user/
cp $BUILD_PATH $DEPLOY_PATH

echo "> 현재 실행중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f $JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> $JAR_NAME 배포"
nohup java -jar $DEPLOY_PATH$JAR_NAME &