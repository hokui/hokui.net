FROM hokui/ruby_nginx_base

RUN apt-get -yqq install nodejs nodejs-legacy npm git-core supervisor zlib1g-dev sqlite3 libsqlite3-dev

WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4

ADD package.json package.json
RUN npm install

RUN npm install -g gulp bower

ADD bower.json bower.json
RUN bower install --allow-root

RUN rm -v /etc/nginx/mime.types
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/mime.types /etc/nginx/

ADD docker_supervisor.conf /etc/supervisor/conf.d/supervisord.conf

ADD . /var/app
WORKDIR /var/app
RUN mkdir public

ENV RAILS_ENV=production

RUN cp -r /tmp/node_modules /var/app/node_modules
RUN cp -r /tmp/bower_components /var/app/public/bower_components
RUN gulp build --prod --nosound

EXPOSE 8001

VOLUME ["/var/log/supervisor", "/var/log/nginx", "/var/app/log"]

ENTRYPOINT ["bash", "run.sh"]
