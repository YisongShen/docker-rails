#Ruby
FROM ruby:2.3.0-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install libsqlite3-dev

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/dockerexample123

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install sqlite3 -v '1.3.11'
RUN gem install bundler

# Finish establishing our Ruby enviornment
RUN bundle install

EXPOSE 3000
# Copy the Rails application into place
COPY . .

# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD ["bundle","exec","rails","server","-b","0.0.0.0"]
