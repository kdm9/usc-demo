FROM debian:unstable
MAINTAINER Kevin Murray <spam@kdmurray.id.au>

RUN apt-get update && \
    apt-get -yy upgrade && \
    apt-get -yy install python3 less vim && \
    apt-get -yy autoremove  && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD sequence.fasta.gz /root/

WORKDIR /root
RUN echo 'export HOME="/root"'>>/etc/bash.bashrc
RUN echo 'export PATH="/usr/lib/khmer/bin:$PATH"'>>/etc/bash.bashrc
RUN echo 'cd' >>/etc/bash.bashrc
