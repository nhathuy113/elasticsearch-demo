FROM ruby:3.1.6

# Install system dependencies
RUN apt-get update -y \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/*

## Install Rails and gems
#RUN apt-get update && apt-get install -y curl wget gnupg2 \
#    && curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/channels/secure/google-cloud-sdk/debs/ main" > /etc/apt/sources.list.d/google-cloud-sdk.list' \
#    && apt-get update \
#    && apt-get install -y google-cloud-sdk \
#    && apt-get install -y build-essential zlib1g-dev \
#    && bundle install --local --jobs=4 \
#    && bundle config build.nokogiri --use-system-libraries \
#    && bundle exec rails new ../app --skip-bundle \
#    && cd ../app \
#    && bundle install --jobs=4 --retry=3

WORKDIR /es-demo

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs=4 --retry=3

# Copy application files
COPY . .

# Create symbolic links
#RUN ln -sf . /es-demo/current_directory
#RUN ln -sf C:\Users\nhath\RubymineProjects\rspec-boilerplate /es-demo
#RUN ln -sf . /es-demo

# Run migrations
#RUN bundle exec rails db:create db:migrate

# Start Rails server
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "'0.0.0.0'"]
