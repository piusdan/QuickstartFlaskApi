#!/usr/bin/env sh

exec gunicorn autoapp:app -b :5000 -w $GUNICORN_WORKERS -k gevent --max-requests=5000 --max-requests-jitter=500 --log-level=$LOG_LEVEL