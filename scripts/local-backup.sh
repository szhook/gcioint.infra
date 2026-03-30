SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

docker exec -it mysql /bin/sh -c 'mysqldump gciocom -u bitrix -pnC96l:D\)Fy8O > /migrations/db.sql'

cd web/prod
tar --exclude "bitrix/cache" --exclude "bitrix/html_pages" --exclude "bitrix/managed_cache" --exclude "bitrix/backup" -cvzf $SCRIPT_DIR/../private/migrations/bx.tar.gz bitrix/ 
tar --exclude "upload/resize_cache" --exclude "upload/tmp" --exclude "upload/4f8ac07e800937c24df5ae689618255b" -cvzf $SCRIPT_DIR/../private/migrations/up.tar.gz upload/
