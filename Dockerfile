FROM docker.io/rclone/rclone:1.63.0 AS rclone
FROM docker.io/kopia/kopia:20230718.0.182324 AS kopia
FROM docker.io/restic/restic:0.15.2 AS restic
FROM docker.io/alpine:3.18 AS downloader
WORKDIR /tmp
RUN  wget https://github.com/go-task/task/releases/download/v3.27.1/task_linux_amd64.tar.gz && \
     tar zxvf task_linux_amd64.tar.gz

FROM docker.io/alpine:20230329 AS base
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
