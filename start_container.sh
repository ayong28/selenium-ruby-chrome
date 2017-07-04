# This command runs the container and assigns the name 'cuke-runner'
docker run --name cuke-runner -v /dev/shm:/dev/shm -v ~/projects/customer-orders-entry-frontend/test/cucumber/:/cuke-test -d -p 4444:4444 -p 5900:5900 happycamper28/selenium-ruby-chrome

