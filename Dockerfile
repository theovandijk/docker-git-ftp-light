FROM alpine:3.5
MAINTAINER Theo van Dijk <thvdijk@gmail.com>

#install packages
RUN apk add --no-cache git && \
    apk add --no-cache curl && \
    apk add --no-cache make
#get git-ftp source
RUN git clone https://github.com/git-ftp/git-ftp.git
#install git-ftp and remove source
RUN cd git-ftp && \
    tag="$(git tag | grep '^[0-9]*\.[0-9]*\.[0-9]*$' | tail -1)" && \
    git checkout "$tag" && \
    make install && \
    cd .. && \
    rm -Rf git-ftp
#create a folder to mount the git source on
RUN mkdir source
WORKDIR /source