# syntax=docker/dockerfile:1

FROM ghcr.io/arkountos/vitaminv-ubuntu-base:0.0.2

COPY *.py /bench/
WORKDIR /bench/

RUN apt install -y zlib1g-dev libjpeg-dev libffi-dev libpng-dev libtiff-dev \
    && apt install -y python3 pip \ 
    && pip install --no-cache-dir pillow minio
    #&& pip --no-cache-dir install -i https://test.pypi.org/simple/ ptpsync

CMD [ "gunicorn", "-b", "0.0.0.0", "-w", "1", "server:app" ]
