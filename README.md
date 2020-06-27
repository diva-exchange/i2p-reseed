I2P Reseed Server
=================

Credits: work based on https://github.com/MDrollette/i2p-tools/. Please see the README there to understand the roots of this project.

Source Code: https://codeberg.org/diva.exchange/i2p-reseed

## Changes & Important Notes

This version of the I2P Reseed Server does neither implement any (bandwidth) throttling nor any user agent checks. This makes the server slightly lighter (the dependency to "github.com/throttled/throttled" has been removed). In general, at diva.exchange, we would like to have a minimum of dependencies. But that's just our view.

As a consequence, the network infrastructure must protect this I2P Reseed Server from abuse (like DoS). A reverse proxy (like nginx), a load balancer and a suitable firewall infrastructure is therefore a necessity.

Target user group: advanced users.

## Get Started
We recommended to run this I2P reseed server as a docker container. Pull it as:
`docker pull divax/i2p-reseed`

A persistent docker volume is recommended. This is needed to store the keys (private and public). Therefore:

`docker volume create i2preseed`

To start the container it is required to pass your signer ID to the container. This is done via an environment variable (-e).

Either the signer ID is already available within the persistent container volume, or it gets created.

`docker run -e "SIGNER=abc@xyz.tld" -d -p 8443:8443 --mount type=volume,src=i2preseed,dst=/home/i2preseed/ --name i2preseed divax/i2p-reseed:latest`

## Building from Source
Fetch the source code from codeberg, https://codeberg.org/diva.exchange/i2p-reseed, using git or just download it. Example:

`cd /tmp/ && git clone https://codeberg.org/diva.exchange/i2p-reseed`

### Building the Docker Image
Navigate to the i2p-reseed project folder (like `cd /tmp/i2p-reseed`)

Execute `./bin/build.sh`. This will build i2p-tools (Go program) within the Alpine Linux docker container.
 
### Building the Go Program ip-tools on Your Host

Make sure you have "go" installed (like `apt-get install go`). Navigate to the project home (where you have downloaded the code of i2p-reseed from codeberg, like `cd /tmp/i2p-reseed`).

Set the GOPATH, which is the project root,

`export GOPATH=${PWD}`

then navigate to

`cd ./src/i2p-tools` 

and execute

`go install`

and all done. The binary is now available as `./bin/i2p-tools`.

## Contact the Developers

Talk to us via Telegram https://t.me/diva_exchange_chat_de (English or German).

## Addendum - Public key of reseed.diva.exchange
The public key of the diva.exchange reseed server is located within `./certificates`.
