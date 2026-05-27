# Docker Mastery Assignment
## ElevateHub DevOps Track | Student: Edem Adzimah

## What This Project Is About
## What This Project Is About
I containerized a Python Flask web application as part of the Docker Mastery 
Assignment. The project covers the complete Docker workflow from building a 
Docker image on my local machine, pushing it to three different container 
registries, and finally running a full three service application using Docker 
Compose where Flask, Redis and PostgreSQL all work together.

## My Registry URLs

| Registry | URL |
|----------|-----|
| DockerHub | https://hub.docker.com/r/edemadzimah/flask-app |
| GHCR | ghcr.io/edemdzimah/flask-app:v1.0 |
| AWS ECR | 071231919766.dkr.ecr.us-east-1.amazonaws.com/flask-app |

## How To Run The Full Stack On Your Machine
Make sure Docker Desktop is installed and running then run this one command:

```bash
docker compose up --build -d
```

That single command starts all three services together. Once they are all 
running visit the app at http://localhost:5000 and you will see the visit 
counter increment every time you refresh.

## How To Test It
```bash
curl http://localhost:5000
```

## How To Shut It Down
```bash
docker compose down -v
```

## Challenges I Faced And How I Solved Them
The first challenge I ran into was during the DockerHub push where I kept 
getting an authorization error. After some checking I realized my DockerHub 
username was edemadzimah but I had been typing edemdzimah which is my GitHub 
username. One extra letter was causing the whole thing to fail. Once I used 
the correct username everything pushed perfectly.

The second challenge was that after running Docker Compose, the web service 
was showing as unhealthy even though the app was responding correctly to 
requests. I figured out that the health check was trying to use curl inside 
the container but curl was not installed in the Python slim base image. I 
fixed it by adding a line to the Dockerfile to install curl during the build 
and after rebuilding the container all three services showed as healthy.

## What I Learned
This assignment gave me real hands on experience with the kind of Docker 
workflow that is used in actual DevOps jobs. I now understand how to build 
production ready images, push them to multiple registries including DockerHub, 
GitHub and AWS ECR, and wire up multi service applications using Docker Compose. 
The most exciting moment was watching three separate services start up and 
communicate with each other from a single command.