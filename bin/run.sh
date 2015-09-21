#!/bin/bash

set -e

[ "$DEBUG" == "1" ] && set -x && set +e

if [ "${MYSQL_ROOT_PASSWORD}" == "**ChangeMe**" -o -z "${MYSQL_ROOT_PASSWORD}" ]; then
   echo "*** ERROR: you need to define MYSQL_ROOT_PASSWORD environment variable - Exiting ..."
   exit 1
fi

if [ "${REPLICATION_MASTER}" == "**ChangeMe**" -o -z "${REPLICATION_MASTER}" ]; then
   export REPLICATION_MASTER=false
fi

if [ "${REPLICATION_SLAVE}" == "**ChangeMe**" -o -z "${REPLICATION_SLAVE}" ]; then
   export REPLICATION_SLAVE=false
fi





# Set MySQL port
perl -p -i -e "s/port = .*/port = ${MYSQL_PORT}/g" ${MYSQL_CONF}


