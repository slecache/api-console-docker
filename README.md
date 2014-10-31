# api:Console in Docker

A [Docker](http://www.docker.io/) image to run the [api:Console](https://github.com/mulesoft/api-console) for your REST API documentation with [RAML](http://raml.org).

## Installation

### Download from Docker Hub
    docker pull slecache/api-console

### Build Docker Image
    docker build -t slecache/api-console

## Quick start

### How to use this image
    docker run -p 9000:9000 -d slecache/api-console
Then, access it via `http://localhost:90000` in a browser.

### How to deploy your API
Your main RAML file MUST be named `main.raml`.

#### Mounting local volume
    docker run -v /your_local_folder_where_are_your_raml_files:/data/app/apis --name DATA busybox true
    docker run --volumes-from DATA -p 9000:9000 -p 35729:35729 -d slecache/api-console
_Please note that the live reload is activated. The edition of any files in your folder will provoke the auto-reloading of your api:Console in your browser. _

#### Building custom image
At the root of your RAML documentation folder where the `main.raml` MUST be present, create the following `Dockerfile`:

    FROM slecache/api-console

Then, run the build command :

    docker build -t your_imahge_name .

All yours documentations files will be copied in the `/data/app/apis` of the Docker Image.

## User feedback
Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/slecache/api-console-docker/issues).

### Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
