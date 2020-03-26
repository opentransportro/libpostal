FROM node:10.18-buster

# install libpostal
RUN apt-get update
RUN apt-get install -y --no-install-recommends git curl make libsnappy-dev autoconf automake libtool python pkg-config

RUN mkdir -p /mnt/data

# Where the app is built and run inside the docker fs
ENV LIBPOSTAL=/opt/libpostal

WORKDIR ${LIBPOSTAL}
ADD . ${LIBPOSTAL}

RUN ./bootstrap.sh \
  && ./configure --datadir=/mnt/data \
  && make -j4 \
  && make install \
  && ldconfig

RUN rm -rf ${LIBPOSTAL}