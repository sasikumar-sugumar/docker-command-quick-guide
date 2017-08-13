# Welcome to quick-guide

For full documentation visit [mkdocs.org](http://mkdocs.org).

## Install Docker

* `sudo yum update -y` - Update the repository
* `sudo yum install -y docker -y` - Install docker
* `sudo service docker start` - Start the docker host
* `sudo usermod -a -G docker ec2-user` - add the list to truster users
* `docker info` - print docker info to confirm

## Docker Clean Up Containers

    docker rmi $(docker images -q) # remove all the images
    docker rmi -f $(docker images -q)` # force remove all the images

## Docker-Compose Basic Commands

    docker rmi $(docker images -q) # remove all the images
    docker rmi -f $(docker images -q)` # force remove all the images


## Basic Commands

* `docker ps` - List all running contianers.
* `docker ps -a` - List all running and stopped contianers.
* `docker images` - List all docker images.


## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.


## Docker-Compose Basic Commands

    docker-compose up # build and run all containers in terminal
    docker-compose up -d # build and run all containers as daemon thread
    docker-compose stop # stop all the container defined in compose file
    docker-compose rm # remove all container defined in compose file
    docker-compose rm -f # force remove all container defined in compose file
    docker-compose stop && docker-compose rm -f # Stop and remove all container defined in compose file