FROM nginxinc/nginx-unprivileged:1.30-alpine

USER root
RUN apk upgrade --no-cache libexpat
USER 101