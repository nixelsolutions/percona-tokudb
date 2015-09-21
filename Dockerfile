FROM ubuntu:14.04

MAINTAINER Manel Martinez <manel@nixelsolutions.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://repo.percona.com/apt trusty main" > /etc/apt/sources.list.d/percona.list
RUN echo "deb-src http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list.d/percona.list

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN apt-get update && \
    apt-get install -y percona-server-tokudb-5.6 supervisor

ENV MYSQL_PORT 3306
ENV MYSQL_ROOT_USER root
ENV MYSQL_ROOT_PASSWORD **ChangeMe**
ENV REPLICATION_MASTER **ChangeMe**
ENV REPLICATION_SLAVE **ChangeMe**
ENV REPLICATION_USER **ChangeMe**
ENV REPLICATION_PASSWORD **ChangeMe**
ENV REPLICATION_MASTER_HOSTS **ChangeMe**
ENV REPLICATION_SLAVE_HOSTS **ChangeMe**

ENV MYSQL_VOLUME /var/lib/mysql
ENV MYSQL_CONF /etc/mysql/conf.d/tokudb.cnf
ENV MYSQL_REPLICATION_FLAG /mysql.replication.set

ENV DEBUG 0

EXPOSE ${MYSQL_PORT}

RUN mkdir -p /var/log/supervisor

VOLUME ["${MYSQL_VOLUME}"]

RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh
ADD ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./etc/mysql /etc/mysql

CMD ["/usr/local/bin/run.sh"]
