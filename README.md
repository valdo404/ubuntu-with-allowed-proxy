# Corporate Proxy Certificate Handler

This project provides a Docker solution for handling corporate proxy SSL certificates in containerized environments.

## Purpose

When working behind a corporate proxy that performs SSL inspection, Docker containers need the proxy's root certificate to make HTTPS connections. This Dockerfile automates the process of:

1. Retrieving the proxy's certificate from a specified host
2. Installing it
3. Enabling secure HTTPS communications through the corporate proxy

## Usage

### Basic Build
```bash
docker build -t ubuntu-with-cert .
```

### Parameterized build
```bash
docker build \
--build-arg BASE_IMAGE=debian:latest \
--build-arg TARGET_HOST=your.proxy.host \
-t custom-with-cert .
```