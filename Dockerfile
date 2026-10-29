FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs

RUN mkdir /nokoripo
WORKDIR /nokoripo


COPY Gemfile /nokoripo/Gemfile
COPY Gemfile.lock /nokoripo/Gemfile.lock


RUN bundle install


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000


CMD ["rails", "server", "-b", "0.0.0.0"]

