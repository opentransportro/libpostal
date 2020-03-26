FROM node:10.18-buster

# install libpostal
RUN apt-get update
RUN apt-get install -y --no-install-recommends git curl make libsnappy-dev autoconf automake libtool python pkg-config

RUN mkdir -p /mnt/data

RUN git clone --single-branch https://github.com/opentransportro/libpostal \
  && cd libpostal \
  && ./bootstrap.sh \
  && ./configure --datadir=/mnt/data \
  && make -j4 \
  && make install \
  && ldconfig