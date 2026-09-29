FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    git \
    nano \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Buat user
RUN useradd -m -s /bin/bash dwikuyz00 \
    && echo "dwikuyz00:dwikuyz00" | chpasswd \
    && usermod -aG sudo dwikuyz00

# Konfigurasi SSH
RUN mkdir -p /run/sshd \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
