FROM ruby:2.7-alpine as builder
RUN apk add --update --no-cache make gcc musl-dev tzdata g++ patch patch
RUN gem install bundler -v 2.1.4
ADD Gemfile Gemfile.lock /root/
WORKDIR /root/
RUN bundle install

FROM ruby:2.7-alpine
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
RUN apk add --update --no-cache git nodejs
RUN adduser -D jekyll
WORKDIR /home/jekyll
USER jekyll
CMD ["jekyll", "serve", "-l"]
