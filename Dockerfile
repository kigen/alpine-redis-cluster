FROM redis:alpine

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="alpine-redis-cluster" \
      org.label-schema.description="Redis cluster ready image based on alpine distro" \
      org.label-schema.url="https://www.254bit.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kigen/alpine-redis-cluster" \
      org.label-schema.vendor="254Bit" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="0.1.0"

RUN apk update && apk upgrade\
    && apk --no-cache add --virtual .build-deps ruby ruby-dev ruby-irb ruby-rdoc wget\
    && gem install redis -v 3.3.5\
    && apk del .build-deps\
    && rm -rf /var/cache/apk/*
    
RUN wget -O /usr/local/bin/redis-trib http://download.redis.io/redis-stable/src/redis-trib.rb
RUN chmod 755 /usr/local/bin/redis-trib
CMD redis-server