FROM alpine:latest
MAINTAINER playniuniu < playniuniu@gmail.com >

ENV BUILD_DEP build-base python-dev py-virtualenv libffi-dev openssl-dev
ENV PACKAGE_BASE python

WORKDIR /usr/src/app/

RUN apk add --update --no-cache $PACKAGE_BASE $BUILD_DEP \
    && virtualenv ./env \
    && /usr/src/app/env/bin/pip install cffi \
    && /usr/src/app/env/bin/pip install ansible pywinrm \
    && apk del $BUILD_DEP \
    && rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
