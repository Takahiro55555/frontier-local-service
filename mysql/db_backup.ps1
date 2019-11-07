$SNOPY_BACKUP="C:\Users\RPGLocal2018\iCloudDrive\backup\database_snopy"

# ここからデイリーバックアップ
$DAYLY_BACKUP_PATH = Join-Path $SNOPY_BACKUP "daily"
$DAYS=5
$file_count = (Get-ChildItem $DAYLY_BACKUP_PATH | ? { ! $_.PsIsContainer }).Count

# 古いファイルの削除($DAYS以上前)
if( $file_count -ge $DAYS ){
    Get-ChildItem $DAYLY_BACKUP_PATH -Recurse | Where-Object {($_.Mode -eq "-a---l") -and ($_.CreationTime -lt (Get-Date).AddDays(-1 * $DAYS))} | Remove-Item -force
}

# データベースのバックアップ
$PORT=3306
$HOST_NAME="localhost"
$DAY=Get-Date -UFormat "%Y-%m-%d"
$FILE_NAME="backup_local" + $DAY + ".dump"
$FILE_PATH=Join-Path $DAYLY_BACKUP_PATH $FILE_NAME
Write-Output $FILE_PATH

mysqldump `
    -u mysql_user `
    -h $HOST_NAME `
    -P $PORT `
    --single_transaction `
    --max_allowed_packet=200M `
    --column-statistics=0 `
    --result-file=$FILE_PATH `
    --default-character-set=binary `
    --add_drop_table snodb


# ここからウィークリーバックアップ
$today_week = (Get-Date).DayOfWeek
$BACKUP_WEEK = "Thursday"
$WEEKLY_BACKUP_PATH = Join-Path $SNOPY_BACKUP "weekly"

# 古いファイルの削除($DAYS以上前)
if( $file_count -ge 30 ){
    Get-ChildItem $WEEKLY_BACKUP_PATH -Recurse | Where-Object {($_.Mode -eq "-a---l") -and ($_.CreationTime -lt (Get-Date).AddDays(-1 * $DAYS))} | Remove-Item -force
}

if( $today_week -eq $BACKUP_WEEK){
    Copy-Item $FILE_PATH $WEEKLY_BACKUP_PATH
}

