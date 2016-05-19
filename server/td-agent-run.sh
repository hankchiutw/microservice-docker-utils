#!/bin/bash

# to access different log files under /var/log/
usermod -aG adm td-agent

chown -R td-agent:td-agent /var/log/td-agent
/etc/init.d/td-agent start
