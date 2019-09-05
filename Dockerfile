FROM python:3.7-alpine
MAINTAINER Dust

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

ENV http_proxy http://127.0.0.1:12333


# RUN pip install -r /requirements.txt

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user