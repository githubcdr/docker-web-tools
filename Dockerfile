FROM rclone/rclone:1.59.2 AS rclone
FROM kopia/kopia:20221021.0.53938 AS kopia
FROM alpine:20220715 AS base
RUN  apk add --update --no-cache libwebp-tools imagemagick git xz ca-certificates restic mariadb-client wget curl openssh-client rsync
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone
COPY --from=kopia /bin/kopia /usr/local/bin/kopia
