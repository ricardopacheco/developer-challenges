FROM ruby:3.4.2

ENV DEBIAN_FRONTEND noninteractive

# Enable parallel downloads in apt
RUN echo 'Acquire::Queue-Mode "host";' >> /etc/apt/apt.conf # Change host for access to disable parallel downloads

# Force apt to retry downloads
RUN echo 'APT::Acquire::Retries=10;' >> /etc/apt/apt.conf

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  pkg-config \
  patch \
  libjemalloc2 \
  libpq-dev \
  postgresql-client \
  libxslt1-dev \
  liblzma-dev

RUN echo 'gem: --no-rdoc --no-ri' >> $HOME/.gemrc

RUN gem uninstall -i /usr/local/lib/ruby/gems/3.4.0 bundler
RUN gem install bundler -v 2.6.5

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs 3

ADD . $APP_HOME
