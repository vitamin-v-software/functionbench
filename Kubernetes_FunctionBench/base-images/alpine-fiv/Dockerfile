FROM scratch
ADD alpine-minirootfs-3.20.3-x86_64.tar.gz /

RUN apk add --no-cache python3 py3-pip
RUN pip install --no-cache-dir --break-system-packages --target=/usr/bin Flask gunicorn pyaes
# --break-system-packages because pip needs to be running in a venv otherwise
# --target to install gunicorn directly on the PATH, because by default it's not!

CMD ["/bin/sh"]
