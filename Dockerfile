FROM qnib/syslog
MAINTAINER "Christian Kniep <christian@qnib.org>"

## 
RUN dnf update -y \
 && dnf install -y postgresql-server postgresql-contrib \
 && su -l -c "pg_ctl -c initdb" postgres
ADD etc/supervisord.d/postgres.ini /etc/supervisord.d/
ADD var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/
ADD var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/
RUN chown postgres: /var/lib/pgsql/data/*
ADD etc/consul.d/check_psql.json /etc/consul.d/
