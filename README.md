# Assemblyline

This is the new version of Assemblyline, it is a libary and a cli tool for building and testing applications in containers.

## Support

Initialy ruby support is planned other languages will be added as required.

## What will it do?

Assemblyline uses the Assemblyfile and other standard config files to:

* Generate Dockerfiles used to build prod and dev/test container images.
* Generate kubernetes config to:
  * Run the application in development
  * Run the tests in development or on CI
  * Run the application in prod like environments (prod, staging, QA etc)
 
 It will also provide a developer friendly cli to orchistrate common dev and test tasks.

## Container Images

Building container images with a Dockerfile can get complex when trying to build
minimal images. Assemblyline simplifies this by templating a best practice stratgy
for each supported use case. If your needs are more complex you can access the
full power of the Dockerfile by adding a template to your application.
