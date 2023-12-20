FROM docker.io/rclone/rclone:1.65.0 AS rclone
FROM docker.io/kopia/kopia:20231212.0.40346 AS kopia
FROM docker.io/restic/restic:0.16.2 AS restic
FROM docker.io/alpine:20231219 AS downloader
ARG  TARGETARCH
WORKDIR /tmp
RUN  wget https://github.com/go-task/task/releases/download/v3.27.1/task_linux_${TARGETARCH}.tar.gz && \
     tar zxvf task_linux_${TARGETARCH}.tar.gz

FROM docker.io/alpine:20231219 AS base
LABEL org.opencontainers.image.title "Hosting tools"
LABEL org.opencontainers.image.description "Hosting tools, rsync, restic, kopia, rclone, imagemagick, git, xz, ca-certificates, mariadb-client, wget, curl, openssh-client, rsync, task etc."
LABEL org.opencontainers.image.authors "githubcdr"
LABEL org.opencontainers.image.source "http://github.com/githubcdr/docker-hosting-tools"
LABEL org.opencontainers.image.licenses "MIT"
LABEL org.opencontainers.image.vendor "githubcdr"

RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates mariadb-client wget curl openssh-client rsync
COPY --from=downloader /tmp/task /usr/local/bin/
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/
COPY --from=restic /usr/bin/restic /usr/local/bin/
COPY --from=kopia /bin/kopia /usr/local/bin/
