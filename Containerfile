#FROM quay.io/toolbx-images/alpine-toolbox:3.17
FROM mcr.microsoft.com/azure-cli:latest
#FROM docker.io/library/ubuntu:latest
#FROM quay.io/toolbx-images/ubuntu-toolbox:22.04

LABEL org.opencontainers.image.description="This image is meant to be used with the toolbox or distrobox command"
LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="rudelsaldivar@gmail.com"

COPY extra-packages /
RUN apk update && \
    apk upgrade && \
    cat /extra-packages | xargs apk add
#RUN apt update && \
#    apt upgrade -y; apt autoremove -y && \
#    cat /extra-packages | xargs apt install -y
RUN rm /extra-packages

# TELEPORT
RUN curl https://goteleport.com/static/install.sh | bash -s 13.1.1

# TERRAFORM
##RUN release=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
#RUN curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v > tf_latest
##RUN wget "https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip"
#RUN cat tf_latest
ENV TERRAFORM_VERSION 1.5.0
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    chmod -v +x terraform && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# DISTROBOX HOST-EXEC
RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/minikube && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/kind && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update