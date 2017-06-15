# Docker container for running Ruby Cucumber/Selenium tests

This container uses the docker container from SeleniumHQ the main repository is at 
https://github.com/SeleniumHQ/docker-selenium 

The docker image that this container is building off is `selenium/standalone-chrome-debug:3.4.0-actinium` which contains Google Chrome v58 and Chromedriver v29.

To get the latest version of Chrome and Chromedriver you need to rebuild this image by replacing
in the Dockerfile
`FROM selenium/standalone-chrome-debug:3.4.0-actinium` 
with what ever is the latest version.

## Run the container
`docker run --name cuke-runner -v /dev/shm:/dev/shm -v ~/workspace/docker/simple-test/:/cuke-test -d -p 4444:4444 -p 5900:5900 happycamper28/selenium-ruby-chrome`

#### Explanation of `docker run` options: 
* `--name cuke-runner` - run this container with the name "cuke-runner"
* `-v ~/workspace/docker/simple-test/:/cuke-test` - mounts the local directory to the `/cuke-test` directory in the container
* `-d` - run in detached mode
* `-p 4444:4444` - expose port 4444 which is where the selenium server is listening on
* `-p 5900:5900` - expose port 5900 which is where the vnc server is listening on
* `-v /dev/shm:/dev/shm` - mount the host shared memory to the container to avoid chrome crashing

## View the tests running in the container via VNC 

To view the running tests, connect to the container via VNC on `localhost:5900`

** NOTE: ** VNC password = secret 

For Mac users:
* Use spotlight (cmd + space)
* Type "screen sharing"
* Press "Enter"
* enter "localhost:5900"
* enter password = "secret"

## Execute a test inside the container 
Configure the selenium driver to use chromedriver located at `/usr/bin/chromedriver` inside the container.

Selenium webdriver config 
```ruby
Capybara.register_driver :selenium do |app|
  @chromedriver_path = '/usr/bin/chromedriver'
  Selenium::WebDriver::Chrome::driver_path = @chromedriver_path
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :switches => %w[--disable-popup-blocking, --disable-extensions])
end
```


## Execute a test from outside the container
Selenium webdriver config:

```ruby
url = 'http://localhost:4444/wd/hub'
capabilities = Selenium::WebDriver::Remote::Capabilities.chrome

Capybara.register_driver :selenium_grid_remote_browser do |app|
  Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url, :desired_capabilities => capabilities )
end

Capybara.default_driver = :selenium_grid_remote_browser

```

## References
* How to run a gui app in Docker - https://linuxmeerkat.wordpress.com/2014/10/17/running-a-gui-application-in-a-docker-container/
* SeleniumHQ - https://github.com/SeleniumHQ/docker-selenium 
* Alternative to seleniumhq docker image - https://github.com/elgalu/docker-selenium 
* 
