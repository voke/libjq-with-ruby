FROM ruby:2.6

ENV LANG=C.UTF-8

# Install Oniguruma
RUN \
  cd /tmp && \
  curl -SL https://github.com/kkos/oniguruma/releases/download/v6.9.1/onig-6.9.1.tar.gz | tar xvz && \
  cd onig-6.9.1 && \
  autoreconf -i && \
  ./configure --disable-dependency-tracking && \
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
RUN ruby extconf.rb && make

ENTRYPOINT ["ruby", "test.rb"]
