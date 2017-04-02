FROM alpine:edge
MAINTAINER playniuniu <playniuniu@gmail.com>

ENV PACKAGE ansible sshpass openssh-client rsync

COPY ansible.cfg /opt/
COPY entrypoint.sh /usr/sbin/

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update --no-cache $PACKAGE \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/ansible/ \
    && mv /opt/ansible.cfg /etc/ansible/ansible.cfg

VOLUME /data

ENTRYPOINT ["/usr/sbin/entrypoint.sh"]

CMD ["ansible","all", "-m", "ping"]
