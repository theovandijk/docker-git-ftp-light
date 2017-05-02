FROM alpine:3.5
MAINTAINER Theo van Dijk <thvdijk@gmail.com>

#install packages
RUN apk add --no-cache \
    bash \
    git  \
    curl \
    make; \
    rm -rf /var/cache/apk/*

#clone git-ftp source, install and remove source
RUN git clone https://github.com/git-ftp/git-ftp.git; \
    cd git-ftp; \
    tag="$(git tag | grep '^[0-9]*\.[0-9]*\.[0-9]*$' | tail -1)"; \
    git checkout "$tag"; \
    make install;\
    cd ..; \
    rm -rf git-ftp;

#create a folder to mount the git source on
RUN mkdir source
WORKDIR /source