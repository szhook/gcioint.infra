#!/usr/bin/env sh
# This script is for scheduled or automated backups, you can use it as an entry script with a bacula client for example

set -e -u

DBNAME="gciocom"
DBFILE="live_gciocom_"`date +"%F"`".sql"

cd /home/site/prod/private/migrations
rm -f live*.gz
docker exec mysql /bin/sh -c 'mysqldump --login-path=local --no-tablespaces --no-data gciocom > /migrations/'$DBFILE
docker exec mysql /bin/sh -c 'mysqldump --login-path=local --no-tablespaces --ignore-table=gciocom.b_user_session --ignore-table=gciocom.b_stat_guest gciocom >> /migrations/'$DBFILE
gzip $DBFILE
