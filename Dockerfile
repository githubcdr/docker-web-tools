FROM docker.io/rclone/rclone:1.66.0 AS rclone
FROM docker.io/kopia/kopia:0.16.1 AS kopia
FROM docker.io/restic/restic:0.16.4 AS restic
FROM cgr.dev/chainguard/wolfi-base

LABEL org.opencontainers.image.title "Hosting tools"
LABEL org.opencontainers.image.description "MariaDB client, Imagemagick, Rsync, WebP, XZ, Restic, Kopia, Rclone, Task and Just"
LABEL org.opencontainers.image.authors "githubcdr"
LABEL org.opencontainers.image.source "http://github.com/githubcdr/docker-hosting-tools"
LABEL org.opencontainers.image.licenses "MIT"
LABEL org.opencontainers.image.vendor "githubcdr"

RUN  apk add --update --no-cache git wget curl openssh-client rsync

COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/
COPY --from=restic /usr/bin/restic /usr/local/bin/
COPY --from=kopia /bin/kopia /usr/local/bin/
