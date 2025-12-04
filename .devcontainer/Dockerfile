FROM mcr.microsoft.com/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       apt-transport-https ca-certificates curl gnupg lsb-release build-essential git sudo \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl (stable)
RUN KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt) \
    && curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install kind (container cluster manager)
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind

# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install k9s (latest release binary)
RUN curl -sL https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_x86_64.tar.gz | tar -xz -C /tmp \
    && mv /tmp/k9s /usr/local/bin/k9s \
    && chmod +x /usr/local/bin/k9s

# Install Node.js (current) and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/bin:${PATH}"

CMD ["sleep", "infinity"]
