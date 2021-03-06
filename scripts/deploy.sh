#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=bookstore-webservice

echo "> Build 파일복사"

cp $REPOSITORY/$PROJECT_NAME/build/libs/*.war $REPOSITORY/

echo "> 현재 구동중인 애플리케이션 pid 확인"

CURRENT_PID=$(pgrep -f war)

echo "현재 구동 중인 애플리케이션pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
        echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
        echo "> kill -9 $CURRENT_PID"
        kill -9 $CURRENT_PID
        sleep 5
fi

echo "> 새 애플리케이션 배포"

JAR_NAME=$(ls -tr $REPOSITORY/*.war | tail -n 1)

echo "> JAR Name: $JAR_NAME"

nohup java -jar \ $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
