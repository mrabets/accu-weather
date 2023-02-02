FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /weather
COPY Gemfile /weather/Gemfile
COPY Gemfile.lock /weather/Gemfile.lock
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
