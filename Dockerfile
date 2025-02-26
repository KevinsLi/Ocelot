FROM debian:stretch-slim

COPY . /srv
WORKDIR /srv

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        build-essential \
        automake \
        cmake \
        default-libmysqlclient-dev \
        libboost-iostreams-dev \
        libboost-system-dev \
        libev-dev \
        libjemalloc-dev \
        libmysql++-dev \
        default-libmysqlclient-dev \
        mariadb-client \
        pkg-config \
        git 
RUN ./configure --with-mysql-lib=/usr/lib/x86_64-linux-gnu/ \
        --with-ev-lib=/usr/lib/x86_64-linux-gnu/ \
        --with-boost-libdir=/usr/lib/x86_64-linux-gnu/ 
RUN make \
    && apt-get purge -y \
        build-essential \
        cmake \    
        pkg-config 
RUN apt-get autoremove -y \
    && apt-get clean -y 
RUN rm -rf /var/lib/apt/lists/* 

ENTRYPOINT [ "/bin/bash", "/srv/entrypoint.sh" ]
