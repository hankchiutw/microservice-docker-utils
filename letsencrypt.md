# Let's Encrypt operation guide

For detail, check [https://github.com/certbot/certbot](https://github.com/certbot/certbot)

### Install
```bash
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto

# do install process
./certbot-auto
```

### Create .pem files
Provide adminstrator's email(`--email`) and domain name of current machine(`-d`).

Use `--test-cert` first, once ok, use without `--test-cert`.
```bash
./certbot-auto certonly --test-cert --standalone --email admin@example.com -d example.com
```

The certificated files will be stored in `/etc/letsencrypt/live/`.

### Running with Docker
If the above methods are not applicable, use Docker as descibed [here](http://letsencrypt.readthedocs.io/en/latest/using.html#running-with-docker).

```bash
sudo docker run -it --rm -p 443:443 -p 80:80 --name certbot \
            -v "/etc/letsencrypt:/etc/letsencrypt" \
            -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
            quay.io/letsencrypt/letsencrypt:latest auth
```

But you still need `certbot-auto` to do renewal.

### Renew
The certification will be [expired every 90 days](http://letsencrypt.readthedocs.io/en/latest/using.html#renewal). To do renewal:
```
./certbot-auto renew
```

### References
- [Let's Encrypt user guide](http://letsencrypt.readthedocs.io/en/latest/using.html)
- [GitHub: certbot](https://github.com/certbot/certbot)
