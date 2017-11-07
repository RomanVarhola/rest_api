FROM ruby:2.4.1

RUN apt-get update && apt-get install -y \ 
  build-essential \ 
  nodejs

WORKDIR /home
RUN mkdir -p /rest_api
WORKDIR /rest_api

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]