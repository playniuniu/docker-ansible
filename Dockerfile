FROM alpine:latest
MAINTAINER playniuniu < playniuniu@gmail.com >

ENV BUILD_DEP build-base python-dev py-virtualenv libffi-dev openssl-dev
ENV PACKAGE_BASE python openssh sshpass

WORKDIR /usr/src/app/

RUN apk add --update --no-cache $PACKAGE_BASE $BUILD_DEP \
    && virtualenv ./env \
    && /usr/src/app/env/bin/pip install --no-cache-dir cffi \
    && /usr/src/app/env/bin/pip install --no-cache-dir ansible pywinrm \
    && apk del $BUILD_DEP \
    && rm -rf /var/cache/apk/*

VOLUME /data
COPY entrypoint.sh /usr/sbin

EXPOSE 22

ENTRYPOINT ["/usr/sbin/entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
