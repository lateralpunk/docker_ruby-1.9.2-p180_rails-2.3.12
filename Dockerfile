FROM alpine:3.7

RUN apk update && apk upgrade
RUN apk add --no-cache bash
SHELL ["/bin/bash", "-c"]

RUN apk add --no-cache curl
RUN apk add --no-cache fortune
RUN apk add --no-cache jpeg
RUN apk add --no-cache libjpeg
RUN apk add --no-cache imagemagick
RUN apk add --no-cache gpgme
RUN apk add --no-cache procps
RUN apk add --no-cache tar
RUN apk add --no-cache gcc 
RUN apk add --no-cache make
RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache shadow
RUN apk add --no-cache ca-certificates && update-ca-certificates
RUN apk add --no-cache tzdata
RUN apk add --no-cache zlib
RUN apk add --no-cache zlib-dev
RUN apk add --no-cache openssl
RUN apk add --no-cache openssl-dev
RUN apk add --no-cache sqlite
RUN apk add --no-cache sqlite-dev
RUN apk add --no-cache gnupg
RUN apk add --no-cache musl-dev
RUN apk add --no-cache linux-headers
RUN apk add --no-cache libxml2-dev
RUN apk add --no-cache libxslt-dev
RUN apk add --no-cache bison
RUN apk add --no-cache autoconf
RUN apk add --no-cache yaml
RUN apk add --no-cache yaml-dev
RUN apk add --no-cache tmux
RUN apk add --no-cache emacs
RUN apk add --no-cache readline 
RUN apk add --no-cache readline-dev

ENV TZ=America/Toronto
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV RUBY_MAJOR 1.9
ENV RUBY_VERSION 1.9.2-p180

RUN mkdir -p /usr/src/ruby
RUN curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" | tar -xjC /usr/src/ruby --strip-components=1
RUN cd /usr/src/ruby && autoconf && ./configure --disable-install-doc && make && make install && cd /root && rm -r /usr/src/ruby

RUN gem install --no-ri --no-rdoc -v 1.6.2 rubygems-update && ruby `gem env gemdir`/gems/rubygems-update-1.6.2/setup.rb
RUN gem install --no-ri --no-rdoc rails -v 2.3.12 
RUN gem install --no-ri --no-rdoc mongrel -v 1.2.0.pre2 
RUN export NOKOGIRI_USE_SYSTEM_LIBRARIES=true && gem install --no-ri --no-rdoc nokogiri -v 1.6.0
RUN gem install --no-ri --no-rdoc authlogic -v 2.1.6; exit 0
RUN gem install --no-ri --no-rdoc calendar_helper -v 0.2.6 
RUN gem install --no-ri --no-rdoc cancan -v 1.3.4 
RUN gem install --no-ri --no-rdoc exchange -v 1.2.2 
RUN gem install --no-ri --no-rdoc fuzzy_match -v 2.1.0 
RUN gem install --no-ri --no-rdoc handles_sortable_columns -v 0.1.2 
RUN gem install --no-ri --no-rdoc hirb -v 0.7.1 
RUN gem install --no-ri --no-rdoc paperclip -v 2.3.1.1 
RUN gem install --no-ri --no-rdoc rqrcode -v 0.10.1 
RUN gem install --no-ri --no-rdoc sqlite3 -v 1.3.8 
RUN gem install --no-ri --no-rdoc sqlite3-ruby -v 1.3.3 
RUN gem install --no-ri --no-rdoc will_paginate -v 2.3.15 
RUN gem install --no-ri --no-rdoc abstract -v 1.0.0 
RUN gem install --no-ri --no-rdoc algorithms -v 0.6.1 
RUN gem install --no-ri --no-rdoc atomic -v 1.1.13 
RUN gem install --no-ri --no-rdoc cheat -v 1.3.3 
RUN gem install --no-ri --no-rdoc chunky_png -v 1.3.8 
RUN gem install --no-ri --no-rdoc open4 -v 1.3.4 
RUN gem install --no-ri --no-rdoc pager -v 1.0.1 
RUN gem install --no-ri --no-rdoc railroad -v 0.5.0 
RUN gem install --no-ri --no-rdoc rbtree -v 0.4.1 
RUN gem install --no-ri --no-rdoc rqrcode -v 0.10.1
RUN gem install --no-ri --no-rdoc sentient_user -v 0.3.2
RUN gem install --no-ri --no-rdoc i18n -v 0.6.5
RUN gem install --no-ri --no-rdoc tzinfo -v 0.3.37

# https://github.com/ImageMagick/ImageMagick/issues/856#issuecomment-343273474
RUN apk add --no-cache ghostscript-fonts 

COPY .emacs .irbrc .tmux.conf /root/

# some monkey-patching going on here
COPY timestamp.rb /usr/local/lib/ruby/gems/1.9.1/gems/activerecord-2.3.12/lib/active_record
COPY sortable_columns.rb /usr/local/lib/ruby/gems/1.9.1/gems/handles_sortable_columns-0.1.2/lib/handles
COPY processor.rb /usr/local/lib/ruby/gems/1.9.1/gems/paperclip-2.3.1.1/lib/paperclip

ENTRYPOINT ["/bin/bash"]

#RUN apk del alpine-sdk curl gcc gpgme gcc make alpine-sdk 
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*


