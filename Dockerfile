FROM python:3.6.6-alpine3.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ARG requirements
ONBUILD COPY ${requirements} /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r ${requirements}

ONBUILD COPY . /usr/src/app