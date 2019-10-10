FROM alpine:latest

# meta
LABEL \
	org.label-schema.maintainer="me codar nl" \
	org.label-schema.name="web-tools" \
	org.label-schema.description="Docker containers with web related tools like cwebp, imagemagick etc." \
	org.label-schema.version="1.0" \
	org.label-schema.vcs-url="https://github.com/githubcdr/docker-web-tools" \
	org.label-schema.schema-version="1.0"

RUN	apk add --update --no-cache libwebp-tools imagemagick
