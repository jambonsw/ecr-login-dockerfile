FROM python:3.6-alpine3.6

RUN apk update && apk upgrade && \
    rm -f /var/cache/apk/* && \
    python3.6 -m pip install awscli --no-cache-dir

CMD aws ecr get-login --no-include-email --region $AWS_REGION
