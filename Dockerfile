FROM python:3.10-slim-bullseye
ENV PYTHONUNBUFFERED 1

RUN \
  apt-get -y update && \
  apt-get install -y gettext && \
  apt-get install -y uwsgi && \
  apt-get clean

ENV LDFLAGS=-L/usr/lib/x86_64-linux-gnu/

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools

ADD requirements.txt /app/
RUN pip install -r app/requirements.txt

ADD Procfile /app
ADD . /app

WORKDIR /app

EXPOSE 8000
ENV PORT 8000

CMD ["honcho", "start"]
