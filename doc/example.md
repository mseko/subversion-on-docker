docker-compose.yml

```
version: '2.2'
services:
 svn:
  image: xxx/subversion-on-docker
  container_name: svn
  ports:
    - "80"
  volumes:
    - /path/volumes/httpconfig:/etc/apache2/conf.d/httpconfig
    - /path/volumes/htpasswd:/etc/apache2/myhtpasswd
  restart: unless-stopped
```
