# yyyy/subversion-on-docker

## Running it

```
docker run -d --name svn-server -e SVN_REPO=repo -v $(pwd)/svn/var/svn:/var/svn -v $(pwd)/svn/etc/apache2/conf.d/:/etc/apache2/conf.d/ -p 8080:80  yyyy/subversion-on-docker
```

or

```
docker-compose up -d
```
(need to write docker-compose.yml)

## Using it

Add User
```
docker exec -t svn-server htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd <username> <password>
```

Then, in a new directory elsewhere:

```
svn co --username davsvn --password davsvn http://0.0.0.0:xxxx/svn/repo
cd testrepo
# add/chg/commit as usual
```

And the magic (do in a new directory)

```
echo "hello" > .greeting
curl -u davsvn:davsvn -X PUT -T .greeting http://0.0.0.0:xxxx/svn/repo/greeting.txt
```

## docker-compose.yml example

```
version: '2.2'
services:
 svn-server:
  image: yyyy/subversion-on-docker
  container_name: svn-server 
  environment:
    - SVN_REPO=repo
  ports:
    - "8080:80"
  volumes:
    - ./svn/var/svn:/var/svn 
    - ./svn/etc/apache2/conf.d/:/etc/apache2/conf.d/
  restart: unless-stopped
```
