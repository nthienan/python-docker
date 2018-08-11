FROM python:3.6.6-alpine3.8

RUN apk --no-cache update && \
    apk --no-cache upgrade

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ARG requirements=requirements.txt
ONBUILD COPY ${requirements} /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r ${requirements}

ONBUILD COPY . /usr/src/app
