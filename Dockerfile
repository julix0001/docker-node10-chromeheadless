FROM node:10-alpine

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.description="Chrome running in headless mode in Node10 - Alpine image" \
      org.label-schema.name="alpine-node-chrome-headless" \
      org.label-schema.schema-version="1.0.0-rc1" \
      org.label-schema.version="latest"

# Installs latest Chromium package.
RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk add --no-cache \
    chromium@edge \
    harfbuzz@edge \
    nss@edge \
    && rm -rf /var/cache/*

WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Autorun chrome headless with no GPU
ENTRYPOINT ["chromium-browser", "--headless", "--disable-gpu", "--disable-software-rasterizer", "--disable-dev-shm-usage"]
