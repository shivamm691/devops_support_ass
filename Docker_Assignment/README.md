## System requirements:-

_docker INStall_.

to check - `docker version`

## Steps of build the image:

    **using Dockerfile **

- start docker

  use command to build the "docker image in the cur dir

  ### use commad

  `docker build -t shivamiamge:V1 . `

# to check image

`docker image ls`

# to check all running container

`docker ps `

# step to run the image container with bash:

`docker run --name shivamc --rm -i -t shivamiamge:V1 bash `

this will run the container name `shivamc ` with a intractive seasion of bash

#to pull image from docker HUB user command
`docker pull shivamm691/shivamiamge:V1`
