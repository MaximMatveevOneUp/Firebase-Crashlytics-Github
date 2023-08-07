FROM node:18-alpine3.15

WORKDIR /app
COPY . /app

RUN apk update \
    && apk add bash git g++ make python3 \
    && yarn global add firebase-tools \
    && apk install -y openjdk-8-jdk \
    && apk install -y ant\
    && apk clean;    

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]

