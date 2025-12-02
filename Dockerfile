FROM ruby:3.2 

RUN apt-get update -qq && apt-get install -y nodejs sqlite3

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . . 

RUN RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000

# CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]
CMD ["rails", "server", "-b", "0.0.0.0"]