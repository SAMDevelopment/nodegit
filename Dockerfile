# Build Git in the container from scratch so we have a newer version that is 
# required for Husky to insert the new commit hooks.

# Don't forget to use the matching version on Netlify
FROM node:14.17.4

# Install required packages
RUN apt-get update && apt-get install -y \
  dh-autoreconf \
  libcurl4-gnutls-dev \
  libexpat1-dev \
  gettext \
  libz-dev \
  libssl-dev

WORKDIR /opt

# Compile Git from source
RUN curl -JLO https://github.com/git/git/archive/v2.32.0.tar.gz \
  && tar -zxf git-2.32.0.tar.gz \
  && cd git-2.32.0 \
  && make configure \
  && ./configure --prefix=/usr \
  && make install
