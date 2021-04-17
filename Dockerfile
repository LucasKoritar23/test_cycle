FROM ruby:2.7.1-alpine

COPY . /test_cycle
COPY . /test_cycle
WORKDIR /test_cycle

RUN apk update
RUN apk add build-base \
    musl \
    curl \
    curl-dev \
    libcurl \
    libpq \
    libxml2-dev \
    libxslt-dev \
    python3 \
    python3-dev \
    bash \
    git \
    vim \
    postgresql-dev \
    sqlite-dev

RUN apk add --no-cache tzdata
ENV TZ America/Sao_Paulo
RUN rm Gemfile.lock
RUN gem install bundler
RUN gem install ruby-debug-ide
RUN gem install ruby debase
RUN bundle install
RUN chmod 777 -R /test_cycle