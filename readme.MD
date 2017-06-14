# Docker container for running Ruby Cucumber/Selenium tests

This container uses the docker container from SeleniumHQ the main repository is at 
https://github.com/SeleniumHQ/docker-selenium 

The docker image that this container is building off is `selenium/standalone-chrome-debug:3.4.0-actinium` which contains Google Chrome v58 and Chromedriver v29.

To get the latest version of Chrome and Chromedriver you need to rebuild this image by replacing
in the Dockerfile
`FROM selenium/standalone-chrome-debug:3.4.0-actinium` 
with what ever is the latest version.

## Run container
`docker run --name cuke-runner -v ~/workspace/docker/simple-test/:/cuke-test -d -p 4444:4444 -p 5900:5900 selenium-ruby-chrome`

### What are the options for?
* `--name cuke-runner` - run this container with the name "cuke-runner"
* `-v ~/workspace/docker/simple-test/:/cuke-test` - mounts the local directory to the `/cuke-test` directory in the container
* `-d` - run in detached mode
* `-p 4444:4444` - expose port 4444 which is where the selenium server is listening on
* `-p 5900:5900` - expose port 5900 which is where the vnc server is listening on

### VNC password = secret

## Execute a test inside the container 
Configure the selenium driver to use the chromedriver located within the container `/usr/bin/chromedriver`.


## Execute a test from outside the container
Configure your selenium driver config to point to the selenium server 
