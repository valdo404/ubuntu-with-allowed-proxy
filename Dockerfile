ARG BASE_IMAGE=ubuntu:latest
ARG TARGET_HOST=files.pythonhosted.org

FROM ubuntu:latest as cert-getter
ARG TARGET_HOST
RUN apt-get update && apt-get install -y \
    openssl \
    && rm -rf /var/lib/apt/lists/*
RUN openssl s_client -connect ${TARGET_HOST}:443 -showcerts </dev/null > cert.pem 2>error.log && \
    cat cert.pem | openssl x509 -outform PEM -out /proxy.local.crt && \
    cat error.log

FROM ${BASE_IMAGE}
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*
COPY --from=cert-getter /proxy.local.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
CMD ["/bin/bash"]
