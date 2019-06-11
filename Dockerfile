FROM openjdk:8-jre-alpine

MAINTAINER wq1019<https://github.com/wq1019>

ENV HOME /apollo

COPY apollo.jar $HOME/apollo.jar
COPY start.sh $HOME/start.sh
COPY portal/portal.conf $HOME/portal/portal.conf
COPY service/service.conf $HOME/service/service.conf

EXPOSE 8070 8080

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache curl bash \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && sed -i "s/exit 0;/tail -f \/dev\/null/g" $HOME/start.sh

CMD ["/apollo/start.sh", "start"]
