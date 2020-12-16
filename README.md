[![Docker Pulls](https://img.shields.io/docker/pulls/jh12z/serve.svg)](https://hub.docker.com/r/jh12z/serve/)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/jh12z/serve)](https://hub.docker.com/r/jh12z/serve/)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/jh12z/serve)](https://hub.docker.com/r/jh12z/serve/)

A no-frills static web server to serve multiple sites from one server by using a simple directory layout.

Suitable for local web development as it makes it every easy to host multiple sites in your machine by using virtual hosting.

**Work in progress:**
- Docker Hub autobuild for multiple platforms not fully working yet.
- Build and release binaries in github.

## Features

- Single static binary
- No dependencies
- Docker images provided
- Multi-platform (x86, ARM)

## Build

To build and install locally, you need `go` installed and then run:

```
go get github.com/jh12z/serve
```

## Docker

Docker images are automatically generated for many platforms and available in [Docker Hub](https://hub.docker.com/r/jh12z/serve).

To run into a container you need to bind a host directory into the container's `/sites` directory.
This host directory should contain all the sites you want to serve.

This is an example of a directory containing 3 sites (`foo.mydomain.com`, `bar.mydomain.com` and `other.mydomain.com`):
```bash
~/sites
├── foo.mydomain.com
│   ├── css
│   │   └── **/*.css
│   ├── favicon.ico
│   ├── images
│   ├── index.html
│   └── js
│       └── **/*.js
├── bar.mydomain.com
│   ├── bundle.js
│   └── index.html
└── other.mydomain.com
    └── test.html
```

As you can see the first level contains the hostnames.

You also need to ensure all hostnames are resolved to the IP address where docker is running.
For local development the best thing is to make it resolve to 127.0.0.1.

There are many ways to do this:
- Adding entries/aliases into `/etc/hosts` for each host

    ```
    127.0.0.1 foo.mydomain.com bar.mydomain.com other.mydomain.com
    ```

- Using something like [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) where you can map a whole domain to an IP

    ```
    address=/mydomain.com/127.0.0.1
    ```

- Configuring a wildcard subdomain in your domain's nameserver

    ```
    *.mydomain.com 3600 IN A 127.0.0.1
    ```

Then run this command:

```
docker run -v ~/sites:/sites -p 80:8080 jh12z/serve
```

You should be able to access all the websites in your browser.

(*) If you cannot bind to port 80 because it's already in use, you can use any other port.
In this case the port doesn't need to be added to the directory names as the server ignores the port part of the virtual host name.
