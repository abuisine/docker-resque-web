FROM ruby:alpine

RUN gem install --no-rdoc --no-ri resque json_pure

ENV REDIS_HOST="redis" REDIS_PORT="6379" REDIS_DB="0"
#RESQUE_WEB_HTTP_BASIC_AUTH_USER and RESQUE_WEB_HTTP_BASIC_AUTH_PASSWORD

WORKDIR /data

EXPOSE 5678
CMD resque-web -F -r ${REDIS_HOST}:${REDIS_PORT}:${REDIS_DB}
