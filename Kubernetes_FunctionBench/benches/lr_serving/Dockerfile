# syntax=docker/dockerfile:1

FROM ghcr.io/arkountos/vitaminv-ubuntu-base:0.0.2

COPY *.py /bench/
WORKDIR /bench

RUN apt install -y libffi-dev \
    && pip install --no-cache-dir minio
    #&& pip --no-cache-dir install -i https://test.pypi.org/simple/ ptpsync

CMD [ "gunicorn", "-b", "0.0.0.0", "-w", "1", "server:app" ]
