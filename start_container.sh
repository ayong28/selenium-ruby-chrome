# This command runs the container and assigns the name 'cuke-runner'
if [ ! "$(docker ps -q -f name=cuke-runner)" ]; then
    # run container
    docker run --name cuke-runner -v /dev/shm:/dev/shm -v $PWD/:/cuke-test \
      -d -p 4444:4444 \
      -p 5900:5900 \
      -i happycamper28/selenium-ruby-chrome

    while [ ! "$(docker ps -q -f name=cuke-runner)" ]; do
      echo "$(date) - waiting for container to start"
      sleep 2
    done
fi
