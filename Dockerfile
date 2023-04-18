FROM docker.io/rclone/rclone:1.62.2 AS rclone
FROM docker.io/kopia/kopia:20230416.0.234826 AS kopia
FROM docker.io/alpine:20230329 AS base

LABEL org.opencontainers.image.title "Hosting tools"
LABEL org.opencontainers.image.description "Hosting tools, rsync, restic, kopia, rclone, imagemagick, git, xz, ca-certificates, mariadb-client, wget, curl, openssh-client, rsync"
LABEL org.opencontainers.image.authors "githubcdr"
LABEL org.opencontainers.image.source "http://github.com/githubcdr/docker-hosting-tools"
LABEL org.opencontainers.image.licenses "MIT"
LABEL org.opencontainers.image.vendor "githubcdr"

RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates restic mariadb-client wget curl openssh-client rsync
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone
COPY --from=kopia /bin/kopia /usr/local/bin/kopia
