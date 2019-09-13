FROM python:3.7-alpine
MAINTAINER Dust

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

# ENV http_proxy http://127.0.0.1:12333
# ENV all_proxy socks5://127.0.0.1:1080

RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tem-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
# RUN pip install -r /requirements.txt

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /requirements.txt

RUN apk del .tem-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user