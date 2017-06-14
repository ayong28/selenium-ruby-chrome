FROM selenium/standalone-chrome-debug:3.4.0-actinium

# Install Ruby.
RUN \
  apt-get update && \
  apt-get install -y ruby ruby-dev ruby-bundler && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update

RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

RUN gem install cucumber -v 2.4.0 --no-ri --no-rdoc
RUN gem install selenium-webdriver -v 3.4.0 --no-ri --no-rdoc
RUN gem install capybara -v 2.13.0 --no-ri --no-rdoc
RUN gem install rspec-expectations -v 3.5.0 --no-ri --no-rdoc
RUN gem install rspec -v 3.5.0 --no-ri --no-rdoc
RUN gem install chronic -v 0.10.2 --no-ri --no-rdoc
RUN gem install httparty -v 0.13.7 --no-ri --no-rdoc
RUN gem install parallel_tests -v 2.6.0 --no-ri --no-rdoc
RUN gem install byebug -v 9.0.5 --no-ri --no-rdoc
RUN gem install poltergeist -v 1.10.0 --no-ri --no-rdoc

