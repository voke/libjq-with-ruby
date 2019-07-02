FROM ubuntu:18.04

ENV LANG=C.UTF-8

# Install ruby and other dependencies
RUN apt-get update && apt-get install -y \
  autoconf \
  build-essential \
  curl \
  libtool \
  ruby-full

# Install Oniguruma
RUN \
  cd /tmp && \
  curl -SL https://github.com/kkos/oniguruma/releases/download/v6.9.1/onig-6.9.1.tar.gz | tar xvz && \
  cd onig-6.9.1 && \
  autoreconf -i && \
  ./configure && \
  make && \
  make install && \
  ldconfig

# Install jq
RUN \
  cd /tmp && \
  curl -SL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz | tar xvz && \
  cd jq-1.6 && \
  autoreconf -i && \
  ./configure --enable-shared --disable-docs --disable-maintainer-mode && \
  make && \
  make install && \
  ldconfig

# Copy example code
COPY ruby-jq-bindings ./ruby-jq-bindings

WORKDIR ruby-jq-bindings

# Create Makefile and make
RUN ruby extconf.rb && make

CMD ["ruby", "test.rb"]
