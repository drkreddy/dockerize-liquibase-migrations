FROM alpine:latest
USER root

RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8

ADD liquibase-3.8.0-bin.tar.gz /usr/local/
COPY change.xml /change.xml
COPY test/snakeyaml-1.25.jar /usr/local/liquibase-3.8.0-bin/lib/snakeyaml-1.25.jar
COPY postgresql-42.2.8.jar /postgresql-42.2.8.jar

ENV OS_STRING jdbc:postgresql://172.17.0.2:5432/postgres

CMD sh /usr/local/liquibase  --classpath=/postgresql-42.2.8.jar --changeLogFile=/change.xml --url=$OS_STRING --username=postgres  --password=mysecretpassword update

