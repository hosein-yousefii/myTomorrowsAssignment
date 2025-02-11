# syntax=docker/dockerfile:1.2
ARG BASE_IMAGE_VERSION="1.0.0"
FROM ghcr.io/hosein-yousefii/mytomorrows/container/python-flask-basis:${BASE_IMAGE_VERSION}

#Envs wil change during deployment, based on the environment.
ENV SECRET_KEY="CHANGEME"
ENV DB_PASSWORD="CHANGEME"
ENV API_BASE_URL="https://example.com/v1"
ENV LOG_LEVEL="debug"
ENV MAX_CONNECTIONS="2"
