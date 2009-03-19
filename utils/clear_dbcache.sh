#!/bin/sh

cd `dirname $0`
. config.sh

echo "
TRUNCATE TABLE cache;
" | psql -q -U $MYSQL_USER $MYSQL_DB

echo "
DELETE FROM cache WHERE (timestamp_db < (now() - INTERVAL '12 hours'));
DELETE FROM cache WHERE (timestamp_db < (now() - INTERVAL '1 hour')) AND (hits = 0);
" | psql -q -U $MYSQL_USER $MYSQL_DB
