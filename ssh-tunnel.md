# SSH tunnel guide

SSH tunnel provides more secure and flexible topologies between network connections.

Mostly SSH tunnel is realized by local port forwarding or remote port forwarding.

Dynamic port forwarding is not covered in this guide.

### What's included

- Local port forwarding 
- Remote port forwarding 

### Local port forwarding
![local-port-forwarding.png](http://i.stack.imgur.com/a28N8.png)
> `ssh -L :sourcePort:forwardToHost:onPort connectToHost`

> `forwardToHost`: host address with respect to **connectToHost**

Explain: login to `connectToHost` and forward **current machine**'s `sourcePort` to `forwardToHost`'s `onPort`.

First `:`(before `sourcePort`) is mandatory to let external client tunnel through the **current machine**.

After tunnel connected, these commands are equal:
```bash
# on current machine
ssh localhost -p sourcePort

# on other machine
ssh ip.of.current.machine -p sourcePort

# on connectToHost
ssh forwardToHost -p onPort
```

### Remote port forwarding
![local-port-forwarding.png](http://i.stack.imgur.com/4iK3b.png)
> `ssh -R sourcePort:forwardToHost:onPort connectToHost`

> `forwardToHost`: host address with respect to **current machine**

Explain: login to `connectToHost` and forward `connectToHost`'s `sourcePort` to `forwardToHost`'s `onPort`.

That is, after tunnel connected, these commands are equal:
```bash
# on current machine
ssh forwardToHost -p onPort

# on current machine
ssh connectToHost -p sourcePort

# on connectToHost
ssh localhost -p sourcePort
```

As described [here](http://askubuntu.com/questions/50064/reverse-port-tunnelling), machine called `connectToHost` should have the setting
```bash
# in /etc/ssh/sshd_config
GatewayPorts yes
```


### References
- [Secure Shell tunneling](https://en.wikipedia.org/wiki/Tunneling_protocol#Secure_Shell_tunneling)
- [SSH Tunnel - Local and Remote Port Forwarding Explained With Examples](http://blog.trackets.com/2014/05/17/ssh-tunnel-local-and-remote-port-forwarding-explained-with-examples.html)
- [StackExchange: difference between local and remote port forwarding](http://unix.stackexchange.com/questions/115897/whats-ssh-port-forwarding-and-whats-the-difference-between-ssh-local-and-remot)
