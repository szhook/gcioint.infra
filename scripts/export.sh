SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

docker exec -it mysql /bin/sh -c 'mysqldump gciocom -u bitrix -p123 | gzip > /migrations/db.gz'
tar --exclude "web/prod/bitrix/cache" --exclude "web/prod/bitrix/managed_cache" --exclude "web/prod/bitrix/backup" -cvzf private/migrations/bx.tar.gz web/prod/bitrix/ 
tar -cvzf private/migrations/up.tar.gz web/prod/upload/
