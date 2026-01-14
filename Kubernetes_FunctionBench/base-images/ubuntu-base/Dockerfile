# syntax=docker/dockerfile:1

FROM ubuntu:22.04

RUN apt update \ 
  && apt install -y python3 pip \
  && pip install --no-cache-dir Flask gunicorn pyaes \
  && pip install --no-cache-dir argon2-cffi black blinker certifi cffi chameleon charset-normalizer click flask gmp gunicorn idna importlib-metadata itsdangerous jinja2 joblib  markupsafe minio mypy-extensions nodeenv numpy packaging pandas pathspec pillow pip platformdirs pyaes pycparser pycryptodome pyright pysocks python-dateutil pytz requests ruff scikit-learn scipy setuptools six threadpoolctl tk typing-extensions urllib3 werkzeug wheel

CMD ["/bin/bash"]
