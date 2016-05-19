# fluentd operation guide

[fluentd](http://docs.fluentd.org/) is a centralized logging system solution.

![architecture](http://docs.fluentd.org/images/fluentd-architecture.png)

### Key concepts
Collect logs from different [sources](http://docs.fluentd.org/articles/input-plugin-overview). Do parse, filter, format, buffer, ...etc. Send data to different [destinations](http://docs.fluentd.org/articles/output-plugin-overview).

### Example Dockerfile
With [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/) and [install latest td-agent](http://docs.fluentd.org/articles/install-by-deb).

```
FROM phusion/baseimage

# install fluentd
# trusty
RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update && apt-get install -y --force-yes td-agent

# mount conf
RUN echo "\n@include /etc/td-agent/example.conf" >> /etc/td-agent/td-agent.conf

# fluentd boot script
RUN mkdir /etc/service/td-agent
ADD td-agent-run.sh /etc/service/td-agent/run
RUN chmod a+x /etc/service/td-agent/run

# boot
CMD ["/sbin/my_init"]
```

##### td-agent-run.sh
```bash
#!/bin/bash

# to access different log files under /var/log/
usermod -aG adm td-agent

chown -R td-agent:td-agent /var/log/td-agent
/etc/init.d/td-agent start
```

### Example .conf file
Input: nginx and mongodb logs

Ouput: AWS S3

```bash
<source>
  @type tail
  format nginx
  path /var/log/nginx/access.log
  pos_file /var/log/td-agent/s3.nginx.access_log.pos
  tag s3.nginx.access
</source>

<source>
  @type tail
  format /^(?<time>.*) (?<level>[A-Z]) (?<type>[A-Z]*)?[ ]*(?<message>\[.*)$/
  path /var/log/mongodb/mongod.log
  pos_file /var/log/td-agent/s3.mongodb.mongod.pos
  tag s3.mongodb.mongod
</source>

<filter s3.nginx.*>
  @type grep
  regexp1 code ^(4|5)
</filter>
 
<match s3.*.*>
  @type s3
  num_threads 8

  # IAM user credential
  aws_key_id xxx
  aws_sec_key xxxx

  s3_region ap-northeast-1
  s3_bucket example-bucket
  path example-path/
  buffer_path /var/log/td-agent/buffer/example-path
 
  time_slice_format %Y%m%d%H
  time_slice_wait 10m
  utc
 
  store_as txt
 
  buffer_chunk_limit 256m
</match>
```
