FROM quay.io/toolbx-images/alpine-toolbox:3.17

#LABEL com.github.containers.toolbox="true" \
LABEL org.opencontainers.image.description \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="rudelsaldivar@gmail.com"

COPY extra-packages /
RUN apk update && \
    apk upgrade && \
    cat /extra-packages | xargs apk add
RUN rm /extra-packages

RUN curl https://goteleport.com/static/install.sh | bash -s 11.2.3

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update