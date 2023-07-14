FROM docker.io/rclone/rclone:1.63.0 AS rclone
FROM docker.io/kopia/kopia:20230713.0.213608 AS kopia
FROM docker.io/restic/restic:0.15.2 AS restic
FROM docker.io/alpine:20230329 AS base

LABEL org.opencontainers.image.title "Hosting tools"
LABEL org.opencontainers.image.description "Hosting tools, rsync, restic, kopia, rclone, imagemagick, git, xz, ca-certificates, mariadb-client, wget, curl, openssh-client, rsync etc."
LABEL org.opencontainers.image.authors "githubcdr"
LABEL org.opencontainers.image.source "http://github.com/githubcdr/docker-hosting-tools"
LABEL org.opencontainers.image.licenses "MIT"
LABEL org.opencontainers.image.vendor "githubcdr"

RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates mariadb-client wget curl openssh-client rsync
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/
COPY --from=restic /usr/bin/restic /usr/local/bin/
COPY --from=kopia /bin/kopia /usr/local/bin/
