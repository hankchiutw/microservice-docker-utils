# Container with authed mongodb

FROM phusion/baseimage
MAINTAINER Hank hankchiu.tw@gmail.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" >> /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update && apt-get install -y mongodb-org

# create boot script
RUN mkdir /etc/service/mongod
RUN echo "#!/bin/bash\nmongod --config /etc/mongod.conf" >> /etc/service/mongod/run
RUN chmod a+x /etc/service/mongod/run


# install fluentd
# debian
#RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
#RUN echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/treasure-data.list
#RUN apt-get update && apt-get install -y --force-yes td-agent

# trusty
RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update && apt-get install -y --force-yes td-agent

# mount conf
RUN echo "\n@include /etc/td-agent/db.conf" >> /etc/td-agent/td-agent.conf

# fluentd boot script
RUN mkdir /etc/service/td-agent
ADD td-agent-run.sh /etc/service/td-agent/run
RUN chmod a+x /etc/service/td-agent/run

# boot
#CMD /boot.sh
CMD ["/sbin/my_init"]
