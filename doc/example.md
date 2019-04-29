# xxx/subversion-on-docker

## Running it

Starting container with docker command:

```
docker run -d -P xxx/subversion-on-docker
```
The container start with the default account: davsvn (password: davsvn) and the default repository: testrepo

```
docker run -d -e SVN_REPO=repo -P paul-hammant/alpine-svn
```
The container start with the default account: davsvn (password: davsvn) and the specified repository: repo

```
docker run -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass -P paul-hammant/alpine-svn
```
The container start with the specified account: user (password: pass) and the default repository: testrepo

```
docker run -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass -e SVN_REPO=repo -P paul-hammant/alpine-svn
```
The container start with the specified account: user (password: pass) and the specified repository: repo


## Using it

Quick and dirty, note the server address:

```
docker ps
```

Then, in a new directory elsewhere:

```
svn co --username davsvn --password davsvn http://0.0.0.0:32772/svn/testrepo
cd testrepo
# add/chg/commit as usual
```

And the magic (do in a new directory)

```
echo "hello" > .greeting
curl -u davsvn:davsvn -X PUT -T .greeting http://0.0.0.0:32772/svn/testrepo/greeting.txt
```

Whereupon you can `svn up` back in the checkout to see it.

Commit messages suck:

    `Autoversioning commit:  a non-deltaV client made a change to`

It would be nice if MOD_DAV_SVN could accept a header for a custom message. Source for that log message [is here](https://svn.apache.org/repos/asf/subversion/trunk/subversion/mod_dav_svn/version.c). There is also a
ticket for that change [SVN-4454](https://issues.apache.org/jira/browse/SVN-4454), that is presently
marked as 'Won't Fix'.

Refer http://svnbook.red-bean.com/en/1.7/svn.webdav.autoversioning.html for canonical SVNAutoversioning info.


## docker-compose.yml(書きかけ)

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
