# Docker Mastery Assignment
## ElevateHub Cloud Computing Track | Student: Edem Adzimah

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


## Bonus D: .dockerignore

I created a .dockerignore file to exclude unnecessary files from 
the Docker build context. The following patterns are excluded:

.git and .gitignore — Git version history is not needed inside 
the container and adds unnecessary size.

screenshots/ — Screenshot files are for human documentation only 
and have no role inside a running container.

README.md — The container does not need to read its own documentation 
to function.

__pycache__ and .pyc files — Python generates fresh compiled files 
during the build so including old ones causes conflicts.

.env — Excluding environment files prevents accidentally baking 
secrets and passwords into the image.

.vscode/ — Editor configuration files are completely irrelevant 
inside a production container.


## Bonus B: Multi-stage Build

I rewrote the Dockerfile to use a multi-stage build to minimize 
the final image size.

Stage 1 (Builder) installs all the Python packages into a specific 
folder called /app/packages using pip with the --target flag.

Stage 2 (Runner) starts from a completely fresh clean Python image 
and copies only the installed packages from Stage 1 leaving all the 
build tools and cache behind.

### Image Size Comparison

| Image | Size | Description |
|-------|------|-------------|
| flask-app:v1.0 | 240MB | Original single stage build |
| flask-app:v2.0-multistage | 231MB | Multi-stage build |

Result: 9MB reduction in image size. In larger production applications 
with many more dependencies this technique can reduce image sizes by 
hundreds of megabytes, improving download speeds and reducing cloud 
storage costs.