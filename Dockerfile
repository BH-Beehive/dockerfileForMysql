FROM mysql:8

COPY ./db/ /docker-entrypoint-initdb.d/

