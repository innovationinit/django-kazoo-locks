FROM registry.futuremind.dev:443/devops/docker-python-base/python/all-in-one:latest

ENV LANG=en_US.UTF-8
ENV TZ=Europe/Warsaw

ENV PYTHONUNBUFFERED 1
ENV PYTHONFAULTHANDLER 1

RUN apk add gcc musl-dev --no-cache

COPY . /tox
COPY docker-entrypoint.sh /docker-entrypoint.sh
VOLUME /tox

WORKDIR /tox

ENTRYPOINT ["/docker-entrypoint.sh"]
