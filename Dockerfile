FROM python:3.8-alpine

WORKDIR /app

ENV PYTHONPATH=/app

COPY requirements .
RUN pip -qq install -r prod.txt \
    && rm -rf *

COPY src/redirecterr.py /app/redirecterr.py
COPY src/templates /app/templates

VOLUME /config

CMD ["sh", "-c", "python -um redirecterr"]
