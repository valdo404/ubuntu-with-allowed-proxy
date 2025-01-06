FROM ubuntu:latest as cert-getter

# Install tools needed for certificate retrieval
RUN apt-get update && apt-get install -y \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Get the certificate
RUN openssl s_client -connect files.pythonhosted.org:443 -showcerts </dev/null 2>/dev/null | \
    openssl x509 -outform PEM -out /proxy.local.crt

# Start fresh with new image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy certificate from cert-getter stage
COPY --from=cert-getter /proxy.local.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

CMD ["/bin/bash"]
