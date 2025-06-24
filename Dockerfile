FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libvips \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN rails db:create db:migrate

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]