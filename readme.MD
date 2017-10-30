# Docker container for running Ruby Cucumber/Selenium tests

This container uses the docker container from SeleniumHQ the main repository is at 
https://github.com/SeleniumHQ/docker-selenium 

The docker image that this container is building off is `selenium/standalone-chrome-debug:3.4.0-actinium` which contains Google Chrome v58 and Chromedriver v29.

To get the latest version of Chrome and Chromedriver you need to rebuild this image by replacing
in the Dockerfile
`FROM selenium/standalone-chrome-debug:3.4.0-actinium` 
with what ever is the latest version.

## Running the container

### Run the container

1. Make sure that your Cuke tests are located in the same directory where you are running the `docker run` command

2. Run the following:

```
docker run --name cuke-runner -v /dev/shm:/dev/shm -v $PWD/:/cuke-test \
  -d -p 4444:4444 \
  -p 5900:5900 \
  -i happycamper28/selenium-ruby-chrome
```

### Stopping the container
`docker rm -f cuke-runner`

#### Explanation of `docker run` options: 
* `--name cuke-runner` - run this container with the name "cuke-runner"
* `-v $PWD/:/cuke-test` - mounts the current working directory to the `/cuke-test` directory in the container
* `-d` - run in detached mode
* `-p 4444:4444` - expose port 4444 which is where the selenium server is listening on
* `-p 5900:5900` - expose port 5900 which is where the vnc server is listening on
* `-v /dev/shm:/dev/shm` - mount the host shared memory to the container to avoid chrome crashing

## View the tests running in the container via VNC 

#### For Mac users:
In the terminal:
```
$ open vnc://:secret@localhost:5900
```

**OR**

1. Use spotlight (cmd + space)
2. Type "screen sharing"
3. Press "Enter"
4. enter "localhost:5900"
5. enter password = "secret"

#### For Windows users:
1. Download any VNC client for Windows (e.g. https://www.realvnc.com/download/vnc/windows/)

> ** Note: ** VNC password = secret 

## Execute a test inside the container 


1. Configure the selenium driver to use chromedriver located at `/usr/bin/chromedriver` inside the container.

  Selenium webdriver config 
  ```ruby
  Capybara.register_driver :selenium do |app|
    @chromedriver_path = '/usr/bin/chromedriver'
    Selenium::WebDriver::Chrome::driver_path = @chromedriver_path
    Capybara::Selenium::Driver.new(app, :browser => :chrome, :switches => %w[--disable-popup-blocking, --disable-extensions])
  end
  ```
2. Make sure you already have mounted your test directory to the docker container, in our example above we have the current working directory already mounted. 

3. Do the following to execute the tests inside the container
   
   ```
   $ docker exec -it cuke-runner bash
   $ cd cuke-test 
   $ cd cucumber 
   $ cucumber
   ```
4. (Optional step) - View the running tests in the container using VNC (see above)

## Use this shell script to run the container, then run the Cuke tests and then stop the container.

1. In the terminal:

```
$ cd selenium-ruby-chrome
$ ./run_test_in_docker.sh
```

## Execute a test from outside the container

> NOTE: This option is only for users who have Ruby and all the relevant Gems installed on their local machine

Selenium webdriver config:

```ruby
url = 'http://localhost:4444/wd/hub'
capabilities = Selenium::WebDriver::Remote::Capabilities.chrome

Capybara.register_driver :selenium_grid_remote_browser do |app|
  Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url, :desired_capabilities => capabilities )
end

Capybara.default_driver = :selenium_grid_remote_browser

```

## If you need to rebuild the image after making changes to the Dockerfile, do this

1. Re-build the docker image
```
$ cd selenium-ruby-chrome
$ docker build -t selenium-ruby-chrome .
```
2. Push the image to docker hub (you need to log in to docker hub first)
```
$ docker push [your-docker-hub-id]/selenium-ruby-chrome
```

## References
* How to run a gui app in Docker - https://linuxmeerkat.wordpress.com/2014/10/17/running-a-gui-application-in-a-docker-container/
* SeleniumHQ - https://github.com/SeleniumHQ/docker-selenium 
* Alternative to seleniumhq docker image - https://github.com/elgalu/docker-selenium 
* Known issues when running tests (Net::ReadTimeout during browser launch) - https://github.com/SeleniumHQ/docker-selenium/issues/198
