cd /docker-entrypoint-initdb.d
gzip -d -f -k ./backup_local2019-01-29.dump.gz
mysql -u mysql_user --default-character-set=utf8 snodb < ./backup_local2019-01-29.dump
rm -f backup_local2019-01-29.dump