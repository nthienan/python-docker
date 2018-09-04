FROM python:2.7.15-alpine3.8

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ARG requirements=requirements.txt
ONBUILD COPY ${requirements} /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r ${requirements}

ONBUILD COPY . /usr/src/app
