FROM node
MAINTAINER Sébastien LECACHEUR "slecache@gmail.com"

#
# install Bower & Grunt
#
RUN npm install -g bower grunt-cli

#
# define working directory.
#
WORKDIR /data

#
# download lastest version of RAML api:Console
#
RUN git clone https://github.com/mulesoft/api-console.git /data \
        && mkdir /data/dist/apis \
        && mv /data/dist/examples/simple.raml /data/dist/apis/main.raml \
        && rm -rf /data/dist/examples \
        && rm -rf /data/src \
        && rm -rf /data/test

#
# install modules and dependencies with NPM and Bower
#
RUN npm install \
        && bower install --allow-root \
        && npm cache clean \
        && bower cache clean --allow-root

#
# add customs files for the API
#
RUN sed -i 's/<raml-initializer><\/raml-initializer>/<raml-console src="apis\/main.raml" resources-collapsed><\/raml-console>/g' /data/dist/index.html
ONBUILD ADD . /data/dist/apis/

EXPOSE 9000
EXPOSE 35729

# start Node.js server with Grunt
ENTRYPOINT ["grunt", "connect:livereload", "watch"]
