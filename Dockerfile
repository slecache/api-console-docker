FROM dockerfile/nodejs-bower-grunt
MAINTAINER Sébastien LECACHEUR "slecache@gmail.com"

#
# download lastest version of RAML api:Console
#
RUN git clone https://github.com/mulesoft/api-console.git /data
RUN mkdir /data/app/apis
RUN mv /data/app/examples/test.raml /data/app/apis/main.raml
RUN rm -rf /data/app/examples
RUN rm -rf /data/dist/examples
RUN rm -rf /data/test

#
# install modules and dependencies with NPM and Bower
#
RUN npm install
RUN bower install --allow-root
RUN npm cache clean
RUN bower cache clean --allow-root

#
# add customs files for the API
#
RUN sed -i '/<raml-console-initializer id="raml-console-loader">/,/<\/raml-console-initializer>/d' /data/app/index.html
RUN sed -i 's/<raml-console with-root-documentation>/<raml-console with-root-documentation src="apis\/main.raml">/g' /data/app/index.html
RUN sed -i "53i\ \ \ \ \ \ \ \ \ \ '<%= yeoman.app %>/apis/**/*.*'," /data/Gruntfile.js
ONBUILD ADD . /data/app/apis/

# start Node.js server with Grunt
ENTRYPOINT ["grunt", "server", "--force"]
