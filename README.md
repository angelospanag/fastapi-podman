# fastapi-podman

An example project using [Podman](https://podman.io/) to run a container with [Python/FastAPI](https://fastapi.tiangolo.com/) for creating a web server and [Poetry](https://python-poetry.org/) for dependency management.

## Podman installation

### Ubuntu/WSL (using `apt`)
```bash
sudo apt install podman
```

### MacOS (using `brew`)
```bash
brew install podman
```

## Podman configuration
The following commands initialise and run `podman` as a daemon on your machine.
### 1. Initialise `podman`
```bash
podman machine init
```

### 2. Start `podman` daemon
```bash
podman machine start
```
Example output:
```bash
INFO[0000] waiting for clients...
INFO[0000] listening tcp://127.0.0.1:7777
INFO[0000] new connection from  to /var/folders/n1/wk2myqkx66vf483r8qg7l2880000gn/T/podman/qemu_podman-machine-default.sock
Waiting for VM ...
Machine "podman-machine-default" started successfully
```

## Podman usage

The following `podman` commands are direct replacements of the Docker CLI. You can see that their syntax is identical:

### 1. Build image and tag it as `fastapi-podman`

The following command uses the `Dockerfile` that is present on the root of the project to build an image. 

Notice that there is no difference in the `Dockerfile` syntax and it can be used 'as is' between Docker and Podman. It still uses [Docker Hub](https://hub.docker.com/_/python/) to fetch the official Python image that is defined in it (`FROM python:3.11`).
```bash
podman image build -t fastapi-podman .
```

### 2. Run a container of the previously tagged image (`fastapi-podman`)

Run our FastAPI application and map our local port `8000` to `80` on the running container:
```bash
podman container run -d --name fastapi-podman -p 8000:80 --network bridge fastapi-podman
```

### 3. Check running containers
```bash
podman ps
```
```bash
CONTAINER ID  IMAGE                            COMMAND               CREATED         STATUS             PORTS                 NAMES
78586e5b4683  localhost/fastapi-podman:latest  uvicorn main:app ...  13 minutes ago  Up 13 minutes ago  0.0.0.0:8000->80/tcp  nifty_roentgen
```
### 4. Hit sample endpoint
Our FastAPI server now runs on port `8000` on our local machine. We can test it with:
```
curl http://localhost:8000
```
Output:
```json
{"Hello":"World"}
```

## Integration with AWS
Similarly, the syntax of the commands that are used to push an image to ECR is identical, just replace `docker` with `podman`.

### Login To ECR
```bash
aws ecr get-login-password --region eu-west-2 | podman login -u YOUR_AWS_USERNAME --password-stdin YOUR_ACCOUNT_NUMBER.dkr.ecr.eu-west-2.amazonaws.com
```
### Push to ECR repo
```bash
podman push YOUR_ACCOUNT_NUMBER.dkr.ecr.eu-west-2.amazonaws.com/fastapi-podman
```
