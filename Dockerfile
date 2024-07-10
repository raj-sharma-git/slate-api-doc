FROM ruby:2.6-slim

WORKDIR /slate/

EXPOSE 4567

COPY . /slate/

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        nodejs \
    && gem install bundler -v 2.4.22 \
    && bundle install \
    && apt-get remove -y build-essential git \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /slate/start.sh
ENTRYPOINT ["/slate/start.sh"]