FROM --platform=amd64 python:3.10.5-alpine3.16

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ARG requirements=requirements.txt
ONBUILD COPY ${requirements} /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r ${requirements}

ONBUILD COPY . /usr/src/app
