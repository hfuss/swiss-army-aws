FROM brix4dayz/swiss-army-knife:latest

USER root

ENV GLIBC_VER=2.31-r0

# install glibc compatibility for alpine
RUN apk --no-cache add \
        binutils \
        curl \
        python2 \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install awscli \
    && apk --no-cache del \
        binutils \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

USER 1001
ENTRYPOINT ["/opt/entrypoint.sh", "aws"]
CMD ["--version"]
