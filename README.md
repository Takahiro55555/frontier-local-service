# docker apache perl mysql

## 概要

### ディレクトリ構成
各ディレクトリは以下のような構成になっている。

```
|- apache: Webサーバのソース
| |- RPG: RPG全体のソース
| |- Dockerfile: RPG全体コンテナを構成するためのDockerfile
| |- httpd.conf: apacheの設定
|- mysql: MySQLの設定とスクリプトのソース
| |- init: DBの初期化用スクリプト入れ
| |- Dockerfile: MySQLコンテナを構成するためのDockerfile
| |- db_backup.ps1: データベースのバックアップスクリプト
| |- cron_db_backup.ps1: db_backup.ps1のクーロンスクリプト
```

RPGはサブモジュールなので、詳細は[korosuke613/frontier-apache](https://github.com/korosuke613/frontier-apache)を参照。

## Start

```bash
docker-compose up
```

先に、バックアップ済みのデータベースファイルが必要。[2_import.sh](https://github.com/korosuke613/frontier-public-service/blob/master/mysql/init/2_import.sh)を参照。

## Directory size
### RPG
- blast 1.76GB
- lib 160KB
- zebradb 2.8MB
