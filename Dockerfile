FROM node:18-alpine3.15

WORKDIR /app
COPY . /app

RUN apk update \
    && apk add bash git g++ make python3 \
    && yarn global add firebase-tools \
    && yarn add java

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]

