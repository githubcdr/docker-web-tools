FROM alpine:20220715

LABEL \
	org.label-schema.maintainer="me codar nl" \
	org.label-schema.name="hosting-tools" \
	org.label-schema.description="Hosting tools for backup and image manipulation." \
	org.label-schema.version="2.0" \
	org.label-schema.vcs-url="https://github.com/githubcdr/docker-hosting-tools" \
	org.label-schema.schema-version="1.0"

#RUN	   echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
#	&& echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \

RUN	TARGETARCH=$(uname -m) \
	&& if [ "$TARGETARCH" = "x86_64" ]; then TARGETARCH="amd64"; fi \
	&& if [ "$TARGETARCH" = "aarch64" ]; then TARGETARCH="arm64"; fi \
	&& if [ "$TARGETARCH" = "armv7l" ]; then TARGETARCH="arm-v7"; fi \
	&& echo "TARGETARCH="${TARGETARCH} \
	&& apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates restic mariadb-client wget curl openssh-client rsync \
	&& curl -O https://downloads.rclone.org/rclone-current-linux-${TARGETARCH}.zip \
	&& unzip rclone-current-linux-${TARGETARCH}.zip \
	&& cd rclone-*-linux-${TARGETARCH} \
	&& cp rclone /usr/bin/ \
	&& chown root:root /usr/bin/rclone \
	&& chmod 755 /usr/bin/rclone \
	&& rm -rf /tmp/*
