FROM rclone/rclone:1.59.1 AS rclone
FROM kopia/kopia:latest AS kopia
FROM alpine:20220715 AS base
RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates restic mariadb-client wget curl openssh-client rsync
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone
COPY --from=kopia /app/kopia /usr/local/bin/kopia
