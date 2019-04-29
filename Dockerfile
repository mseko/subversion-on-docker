FROM alpine:3.9.3

# Install and configure Apache WebDAV and Subversion
RUN apk update && apk --no-cache add apache2=2.4.39-r0 apache2-utils=2.4.39-r0 apache2-webdav=2.4.39-r0 mod_dav_svn=1.11.1-r0 subversion=1.11.1-r0

RUN mkdir -p /run/apache2

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

ADD run.sh /
RUN chmod +x /run.sh

EXPOSE 80

# Define default command
CMD ["/run.sh"]

