FROM alpine:3.9.3

# Proxy settings if necessary
# ENV http_proxy=http://proxy:8080
# ENV https_proxy=http://proxy:8080
# ENV no_proxy="127.0.0.1,localhost,.mydomain.com"

# Install and configure Apache WebDAV and Subversion
RUN apk update && apk --no-cache add apache2=2.4.39-r0 apache2-utils=2.4.39-r0 apache2-webdav=2.4.39-r0 mod_dav_svn=1.11.1-r0 subversion=1.11.1-r0
ADD dav_svn.conf /etc/apache2/conf.d/
RUN mkdir -p /run/apache2

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

ADD run.sh /
RUN chmod +x /run.sh

EXPOSE 80

# Define default command
CMD ["/run.sh"]

