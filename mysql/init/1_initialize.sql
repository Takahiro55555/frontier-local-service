CREATE DATABASE snodb;

CREATE USER mysql_user@localhost;

GRANT ALL ON snodb.* TO mysql_user@localhost;
GRANT ALL ON snodb.* TO mysql_user@'%';
