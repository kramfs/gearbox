#FROM quay.io/toolbx-images/alpine-toolbox:3.17
FROM docker.io/library/ubuntu:latest
#FROM quay.io/toolbx-images/ubuntu-toolbox:22.04

LABEL org.opencontainers.image.description="This image is meant to be used with the toolbox or distrobox command"
LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="rudelsaldivar@gmail.com"

COPY extra-packages /
RUN apt update && \
    apt upgrade -y; apt autoremove -y && \
    cat /extra-packages | xargs apt install -y
RUN rm /extra-packages

#RUN curl https://goteleport.com/static/install.sh | bash -s 11.2.3

#RUN   ln -fs /bin/sh /usr/bin/sh && \
#RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/minikube && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/kind && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update