# Microservice docker utils
Utils to build/manage docker images/containers in a microservice manner.

### Folder structure
```bash
.
├── README.md                   # this file
├── app                         # to manage the node.js docker container
│   ├── Dockerfile-template     # used by build.sh
│   ├── build.sh                # build the docker image. Usage: sudo ./build.sh [APP_NAME] [APP_ENV]
│   ├── developer-key           # will be appended to image's /root/.ssh/authorized_keys
│   │   ├── sample-app-test     # contains string of public key. naming rule: [APP_NAME]-[APP_ENV]
│   │   ├── ...
│   │   ...
│   ├── kill.sh                 # kill and remove the running container. Usage: sudo ./kill.sh [APP_NAME] [APP_ENV]
│   ├── rerun.sh                # concat kill.sh and run.sh. Usage: sudo ./rerun.sh [APP_NAME] [APP_ENV]
│   ├── run.sh                  # print public key and run. Usage: sudo ./run.sh [APP_NAME] [APP_ENV]
│   └── ssh-port                # used by run.sh
│       ├── sample-app-test     # contains host port to be mapped to the container for ssh access
│       ├── ...
│       ...
├── cert
│   ├── build-test.sh           # test creating .pem files. Usage: sudo ./build-test.sh DOMAIN EMAIL
│   ├── build.sh                # create .pem files. Usage: sudo ./build.sh DOMAIN EMAIL
│   ├── install.sh              # install Let's Encrypt client wrapper certbot-auto. Usage: ./install.sh
│   └── renew.sh                # do cert renewal. Usage: sudo ./cert-renew.sh
├── db                          # to manage the database docker container
│   ├── Dockerfile              # used by build.sh
│   ├── build.sh                # build the docker image named 'db'. Usage: sudo ./build.sh
│   ├── data                    # template .conf files. Copy to host folder /data and revise.
│   │   ├── mongod.conf
│   │   └── td-agent
│   │       └── db.conf
│   ├── kill.sh                 # kill and remove the running container. Usage: sudo ./kill.sh
│   ├── rerun.sh                # concat kill.sh and run.sh. Usage: sudo ./rerun.sh
│   ├── run.sh                  # mount persistent data and run. Usage: sudo ./run.sh
│   └── td-agent-run.sh         # td-agent init script. Used in Dockerfile
├── fluentd.md                  # fluentd how-to
├── install.sh                  # install latest docker
├── letsencrypt.md              # Let's Encrypt how-to
├── server                      # to manage proxy server docker container
│   ├── Dockerfile              # used by build.sh
│   ├── build.sh                # build the docker image named 'yw'. Usage: sudo ./build.sh
│   ├── data                    # template .conf files. Copy to host folder /data and revise.
│   │   ├── ssl.conf
│   │   └── td-agent
│   │       └── proxy.conf
│   ├── kill.sh                 # kill and remove the running container. Usage: sudo ./kill.sh
│   ├── rerun.sh                # concat kill.sh and run.sh. Usage: sudo ./rerun.sh
│   ├── run.sh                  # mount persistent data and run. Usage: sudo ./run.sh
│   └── td-agent-run.sh         # td-agent init script. Used in Dockerfile
│   └── tunnel-example.sh
├── ssh-tunnel.md               # port forwarding how-to
└── swap.sh                     # create and enable swap. Usage: sudo ./swap.sh
```

### How it works
- Build docker images from [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/)
- SSH port forwarding. See ssh-tunnel.md
- Centralized logging. See fluentd.md
- Let's Encrypt free SSL certification. See letsencrypt.md
- Store log files on AWS S3 by fluentd [s3 output plugin](http://docs.fluentd.org/articles/out_s3)
- Persistent data on host machine and mounted to the container: local logs, .conf files, database data, cert pem files

host machine directory | mount to container
--- | ---
/data/db | /data/db
/data/mongod.conf | /etc/mongod.conf
/var/log/mongodb | /var/log/mongodb
/var/log/td-agent | /var/log/td-agent
/data/td-agent/db.conf | /etc/td-agent/db.conf
/data/ssl.conf | /etc/nginx/conf.d/default.conf
/data/cert | /etc/nginx/cert

### Network topology
![network](https://www.botmetric.com/wp-content/uploads/2016/03/AWS-Security-Best-Practice-Web.png)

### ToDo
- Use [ansible](https://www.ansible.com/) for automation(replace shell script).
- DNS server for VPC
- MongoDB replica
- RabbitMQ, ZeroMQ

### References
- [Docker -- 從入門到實踐](https://philipzheng.gitbooks.io/docker_practice/content/index.html): including basic docker management(i.e. run, stop, images), [network access](https://philipzheng.gitbooks.io/docker_practice/content/network/index.html), [container](https://philipzheng.gitbooks.io/docker_practice/content/container/index.html), ...etc.
- [fluentd](http://fluentd.org/)
