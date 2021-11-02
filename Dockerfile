FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  python3 \
#  python3-dev \
  python3-pip \
#  build-essential libssl-dev libffi-dev python3-setuptools \
  curl jq vim \
  && rm -rf /var/lib/apt/lists/*

# Install Flask
RUN pip3 install --upgrade pip
RUN pip3 install flask uwsgi


# Copy over the Flask app
RUN mkdir -p /app
COPY ./app/* /app/

COPY ./app/uwsgi.ini /etc/uwsgi/

WORKDIR /app
CMD uwsgi --socket 0.0.0.0:80 --protocol=http -w wsgi:app
