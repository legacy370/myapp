FROM ruby:2.6
LABEL maintainer="n.snyder@shalomcloud.com"
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \ 
  nodejs \
  yarn
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
RUN rails webpacker:install
COPY . /usr/src/app/
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
