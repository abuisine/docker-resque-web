FROM ruby:2.3

MAINTAINER  Alexandre Buisine <alexandrejabuisine@gmail.com>
LABEL version="1.0.0"

ENV BASE_URL="/resque_web"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get install -yqq \
 	nodejs \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

RUN gem install rails --no-ri --no-rdoc \
 && cd / \
 && rails new resque-scheduler-web \
 && cd resque-scheduler-web \
 && echo "gem 'resque-web', require: 'resque_web'" >> Gemfile \
 && echo "gem 'resque-scheduler-web', require: 'resque-scheduler'" >> Gemfile \
 && bundle install

WORKDIR /resque-scheduler-web

RUN sed -i "/Rails.application.routes.draw do/a   mount ResqueWeb::Engine => \"${BASE_URL}\"" config/routes.rb \
 && sed -i "/Rails.application.configure do/a   config.assets.prefix = \"${BASE_URL}/assets\"" config/environments/development.rb \
 && sed -i "s/config.assets.compile = false/config.assets.compile = true/" config/environments/production.rb \
 && echo "development:\n secret_key_base:\n\ntest:\n secret_key_base:\n\nproduction:\n secret_key_base: ${HOSTNAME}" > config/secrets.yml


ENV RAILS_RESQUE_REDIS="redis:6379:0" RAILS_SERVE_STATIC_FILES="true"
# RAILS_LOG_TO_STDOUT="true" 
# RESQUE_WEB_HTTP_BASIC_AUTH_USER="user" RESQUE_WEB_HTTP_BASIC_AUTH_PASSWORD="password"

EXPOSE 80
CMD /resque-scheduler-web/bin/rails server -e production -b 0.0.0.0 -p 80