# syntax=docker/dockerfile:1

FROM ghcr.io/arkountos/vitaminv-ubuntu-base:0.0.2

COPY *.py /bench/
WORKDIR /bench

CMD [ "gunicorn", "-b", "0.0.0.0", "-w", "1", "server:app" ]
