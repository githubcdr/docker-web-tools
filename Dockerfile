FROM docker.io/rclone/rclone:1.67.0 AS rclone
FROM docker.io/kopia/kopia:0.17.0 AS kopia
FROM docker.io/restic/restic:0.16.5 AS restic
FROM cgr.dev/chainguard/wolfi-base

LABEL org.opencontainers.image.title "Hosting tools"
LABEL org.opencontainers.image.description "MariaDB client, Imagemagick, Rsync, WebP, XZ, Restic, Kopia, Rclone, Task and Just"
LABEL org.opencontainers.image.authors "githubcdr"
LABEL org.opencontainers.image.source "http://github.com/githubcdr/docker-hosting-tools"
LABEL org.opencontainers.image.licenses "MIT"
LABEL org.opencontainers.image.vendor "githubcdr"

# libwebp-tools imagemagick git xz ca-certificates mariadb-client wget curl openssh-client rsync just
RUN  apk add --update --no-cache task just libwebp-tools wget curl jq yq xz mariadb openssh-client mc rsync

COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/
COPY --from=kopia /bin/kopia /usr/local/bin/
COPY --from=restic /usr/bin/restic /usr/local/bin/
