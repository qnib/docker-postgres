FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

## 
RUN yum install -y postgresql-server
RUN su -l -c "pg_ctl -c initdb" postgres
ADD etc/supervisord.d/postgres.ini /etc/supervisord.d/
ADD var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/
ADD var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/
RUN chown postgres: /var/lib/pgsql/data/postgresql.conf
ADD etc/consul.d/check_psql.json /etc/consul.d/
