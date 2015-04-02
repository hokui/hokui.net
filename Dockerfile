FROM hokui/ruby_nginx_base

RUN echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu `lsb_release -cs` main \
  && echo deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu `lsb_release -cs` main
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12 \
  && apt-get update \
  && apt-get -yqq install nodejs git-core supervisor

WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD package.json package.json
RUN npm install

ADD bower.json bower.json
RUN bower install

RUN npm install -g gulp

RUN rm -v /etc/nginx/mime.types
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/mime.types /etc/nginx/

ADD docker_supervisor.conf /etc/supervisor/conf.d/supervisord.conf

ADD . /var/app
WORKDIR /var/app

RUN cp -r /tmp/node_modules /var/app/node_modules
RUN cp -r /tmp/bower_components /var/app/public/bower_components
RUN gulp build --prod --nosound

# TODO use volume container
RUN rake db:migrate

EXPOSE 8001

ENTRYPOINT ["/usr/bin/supervisord"]
