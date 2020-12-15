# serve

A static web server to serve multiple virtual hosts.

README file work in progress.

# Features

- Single binary
- No dependencies

# Compile

To download the package and compile run:

```
go get github.com/jh12z/serve
```

# Docker

Docker images are automatically generated for many platforms and available in Docker Hub.
To run the image in a container you need to mount a host directory into the container's `/sites` directory.
This directory should contain all the sites you want to serve.
You also need to ensure all host names are resolved to the IP address where docker is running.
For local development the best thing is to make it resolve to 127.0.0.1.

There are many ways to do this:
- Adding entries into `/etc/hosts`
- Using something like dnsmasq
- Configuring a wildcard subdomain in your nameserver

Then run this command:

```
docker run -v ~/sites:/sites -p 80:8080 jh12z/serve
```
