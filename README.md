# [starcrATI/PIVX-node](https://github.com/starcrATI/PIVX-node)

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/starcrati/pivx-node?style=for-the-badge)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/starcrati/pivx-node?sort=semver&style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/starcrati/pivx-node?style=for-the-badge)

[![PIVX](https://raw.githubusercontent.com/PIVX-Project/Official-PIVX-Graphics/master/icons/colored/pivx-purple-shield%20(PNG)/128x128.png)](https://www.pivx.org/)

[PIVX](https://www.pivx.org) is an open-source and decentralized peer-to-peer currency featuring advanced user data protection features, community governance mechanisms, Proof of Stake consensus algorithm, and multi-purpose Masternodes.

Spin up your node now!

## Usage

Currently only x86_64 is supported, but that may change in the future.
I recommend [docker-compose](https://docs.docker.com/compose/install/) to run this image.

### docker-compose

Create a docker-compose.yml and paste the following snippet in the file. Adjust the parameters to your needs, and start the container.

```yaml
---
version: "2.1"
services:
  pivx-node:
    image: starcrati/pivx-node
    container_name: pivx-node
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - /path/to/data:/data
    ports:
      - 127.0.0.1:51472:51472
      - 127.0.0.1:51473:51473 # optional (for the rpc server)
      - 127.0.0.1:51475:51475 # optional (for the testnet)
    restart: unless-stopped
```

- Start the container: `docker-compose up -d`
- Stop the container: `docker-compose down`
- Update the image
    - First stop the container
	- Pull the new image: `docker-compose pull`
	- Start the container again
- Delete old images: `docker image prune`

### docker cli

```bash
docker run -d \
  --name=pivx-node \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Berlin \
  -p 127.0.0.1:51472:51472 \
  -p 127.0.0.1:51473:51473 \
  -p 127.0.0.1:51475:51475 \
  -v /path/to/data:/data \
  --restart unless-stopped \
  starcrati/pivx-node
```

- Start the container with the command above
- Stop the container: `docker stop pivx-node`
- Upgrade the container
    - First stop the container
	- Pull the new image: `docker pull starcrati/pivx-node`
- Delete old images: `docker image prune`

### Parameters

| Parameter | Usage |
| :----: | --- |
| -e PUID | Set the docker user id to the user id on your host system |
| -e PGID | Set the docker user group id to the user group id on your host system |
| -e TZ | Set your timezone |
| -p 51472 | Use this port if you want to use the mainnet |
| -p 51473 | Use this port if you want to use the rpc server |
| -p 51475 | Use this port if you want to use the testnet |
| -v /path/to/data | Mounts a directory on your host system into the container (contains .pivx and .pivx-params) |
| --restart unless-stopped | Always restarts the container, unless it got shutdown on purpose

## Encrypt your wallet

Please encrypt your wallet! Just for your own favour.

- Connect to the running docker container: `docker exec -it pivx-node /bin/bash`
    - Encrypt wallet: `HOME=/data /app/pivx-${PIVX_VERSION}/bin/pivx-cli encryptwallet <passphrase>`
    - Unconnect from the container: `exit`
- Restart the container

## Acknowledgments

A **huge** thank you goes out to the people at [linuxserver.io](https://www.linuxserver.io/) which created the [ubuntubase-image](https://github.com/linuxserver/docker-baseimage-ubuntu) on which PIVX-node is built upon.

Please consider to [donate here](https://www.linuxserver.io/donate).
