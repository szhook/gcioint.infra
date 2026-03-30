#!/usr/bin/env sh

#export live db
#included_tables=$(awk '{print $1}' incl_tbl.txt | tr '\n' ' ')

docker exec mysql /bin/sh -c "mysqldump --login-path=local --single-transaction --no-tablespaces --no-data gciocom > /migrations/dump-stage.sql"
docker exec mysql /bin/sh -c "mysqldump --login-path=local --no-tablespaces --ignore-table='gciocom.b_stat_guest' --ignore-table='gciocom.b_event_log' --ignore-table='gciocom.b_search_content_stem' --ignore-table='gciocom.b_event' gciocom >> /migrations/dump-stage.sql"

#import db to stage
docker exec mysql /bin/sh -c "mysql --login-path=local -e 'drop database if exists gciocom_stage'"
docker exec mysql /bin/sh -c "mysql --login-path=local -e 'create database gciocom_stage'"
docker exec mysql /bin/sh -c "mysql --login-path=local gciocom_stage < /migrations/dump-stage.sql"
docker exec mysql /bin/sh -c "mysql --login-path=local gciocom_stage < /migrations/stage_users.sql"

rsync -arvz --exclude '*.tar.gz' --exclude 'resize_cache' --exclude 'tmp' --progress --delete ../web/prod/upload/ ../web/stage/upload/
rsync -arvz --exclude-from='exclude.txt' --progress --delete ../web/prod/bitrix/ ../web/stage/bitrix/
sed -i "s/.*'database' =>.*/'database' => 'gciocom_stage',/" ../web/stage/bitrix/.settings.php
