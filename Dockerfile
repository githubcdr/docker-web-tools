FROM rclone/rclone:1.62.2 AS rclone
FROM kopia/kopia:20230315.0.221114 AS kopia
FROM alpine:20230208 AS base
LABEL org.opencontainers.image.source=https://github.com/githubcdr/docker-hosting-tools
RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates restic mariadb-client wget curl openssh-client rsync
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone
COPY --from=kopia /bin/kopia /usr/local/bin/kopia
