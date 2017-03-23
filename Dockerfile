FROM alpine:latest
MAINTAINER playniuniu <playniuniu@gmail.com>

ENV PACKAGE ansible sshpass openssh-client rsync

COPY ansible.cfg /opt/
COPY entrypoint.sh /usr/sbin/

RUN apk add --update --no-cache $PACKAGE \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/ansible/ \
    && mv /opt/ansible.cfg /etc/ansible/ansible.cfg

VOLUME /data

ENTRYPOINT ["/usr/sbin/entrypoint.sh"]

CMD ["ansible","all", "-m", "ping"]
