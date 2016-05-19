# Container with authed mongodb and nginx

FROM phusion/baseimage
MAINTAINER Hank hankchiu.tw@gmail.com

# install required
RUN apt-get update && apt-get install -y nginx curl

# set config
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# create boot script
RUN mkdir /etc/service/nginx
RUN echo "#!/bin/bash\nnginx" >> /etc/service/nginx/run
RUN chmod a+x /etc/service/nginx/run

#RUN echo "#!/bin/bash\nnginx &\nmongod --auth" >> /boot.sh
#RUN chmod a+x /boot.sh

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
RUN echo "\n@include /etc/td-agent/proxy.conf" >> /etc/td-agent/td-agent.conf

# fluentd boot script
RUN mkdir /etc/service/td-agent
ADD td-agent-run.sh /etc/service/td-agent/run
RUN chmod a+x /etc/service/td-agent/run

# boot
#CMD /boot.sh
CMD ["/sbin/my_init"]
