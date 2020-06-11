I2P Reseed Server
=================

Credits: work based on https://github.com/MDrollette/i2p-tools/. Please see the README there to understand the roots of this project.

## Changes & Important Notes

This version of the I2P Reseed Server does neither implement any (bandwidth) throttling nor any user agent checks. This makes the server slightly lighter.

As a consequence, the network infrastructure must protect this I2P Reseed Server from abuse (like DoS). A reverse proxy (like nginx), a load balancer and a suitable firewall infrastructure is therefore a necessity.

Target user group: advanced users.

## Get Started

Pass your signer ID to the container.

Either the signer ID is already available within the persistent container volume, or it gets created.

`docker volume create i2preseed`

`docker run -e "SIGNER=abc@xyz.tld" -d -p 8443:8443 --mount type=volume,src=i2preseed,dst=/home/i2preseed/ --name i2preseed divax/i2p-reseed:latest`

## Public key of reseed.diva.exchange
The public key of the diva.exchange reseed server is located within `./certificates`.

## Building from Source

### Building the Docker Image

Just execute `./bin/build.sh`. This will build ip-tools (Go program) within the Alpine Linux docker container.
 
### Building the Go Program ip-tools on Your Host

Make sure you have "go" installed (like `apt-get install go`).

Set the GOPATH, which is the project root,

`export GOPATH=${PWD}`

then navigate to

`cd ./src/i2p-tools` 

and execute

`go install`

and all done. The binary is now available as `./bin/i2p-tools`.

## Contact the Developers

Talk to us via Telegram https://t.me/diva_exchange_chat_de (English or German).

