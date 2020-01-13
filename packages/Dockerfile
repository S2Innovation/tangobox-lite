FROM ubuntu:eoan AS build

RUN apt update \
 && apt install -y \
    wget \
    g++ \
    make \
    checkinstall \
    openjdk-8-jre-headless \
    omniidl \
    zlib1g-dev \
    libzmq3-dev \
    libomniorb4-dev \
    libcos4-dev \
    libboost-python-dev \
    libmariadb-dev \
    libmariadbclient-dev \
    python3-pip \
    python3-numpy

RUN update-java-alternatives --set java-1.8.0-openjdk-amd64

RUN wget https://github.com/tango-controls/TangoSourceDistribution/releases/download/9.3.4-rc3/tango-9.3.4-rc3.tar.gz \
 && tar xf tango-9.3.4-rc3.tar.gz \
 && rm -rf tango-9.3.4-rc3.tar.gz

RUN cd tango-*/ \
 && ./configure \
  --prefix=/usr/local \
  --without-zlib \
  --enable-mariadb \
  --disable-dbcreate \
  --enable-dbserver

RUN cd tango-*/ \
 && make -j4 \
 && make install

RUN cd tango-*/ \
 && mkdir -p usr/local/share/tango/db \
 && cp cppserver/database/*.sql usr/local/share/tango/db/ \
 && echo './usr/local/share/tango/db/' > include_db.txt

RUN cd tango-*/ \
 && checkinstall \
    --install=no \
    --fstrans=no \
    --showinstall=no \
    --backup=no \
    --type=debian \
    --pkgsource="https://github.com/tango-controls/TangoSourceDistribution" \
    --pkglicense="LGPLv3" \
    --deldesc=no \
    --nodoc \
    --strip \
    --stripso \
    --maintainer="tango" \
    --pkgarch=$(dpkg --print-architecture) \
    --pkgversion="9.3.4-rc3" \
    --pkgrelease="dev" \
    --pkgname=tango-source-distribution \
    --include=include_db.txt \
    --requires="libzmq5,libomniorb4-2,libcos4-2,libomnithread4,libsodium23,libpgm-5.2-0,libmariadb3" \
    make install

RUN ln -s /usr/lib/x86_64-linux-gnu/libboost_python37.so \
          /usr/lib/x86_64-linux-gnu/libboost_python-py37.so

RUN pip3 wheel pytango==9.3.1

FROM alpine:3.11

COPY --from=build \
    /tango-*/tango-source-distribution_9.3.4-rc3-dev_amd64.deb \
    /

COPY --from=build \
    /pytango-9.3.1-cp37-cp37m-linux_x86_64.whl \
    /
