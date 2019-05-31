$SNOPY_BACKUP="C:\Users\RPGLocal2018\iCloudDrive\backup\database_snopy"
$DAYS=9

$file_count = (Get-ChildItem $SNOPY_BACKUP | ? { ! $_.PsIsContainer }).Count

# 古いファイルの削除
if( $file_count -ge 32 ){
    Get-ChildItem $SNOPY_BACKUP -Recurse | Where-Object {($_.Mode -eq "-a----") -and ($_.CreationTime -lt (Get-Date).AddDays(-1 * $DAYS))} | Remove-Item -force
}

# データベースのバックアップ
$PORT=33306
$HOST_NAME="localhost"
$DAY=Get-Date -UFormat "%Y-%m-%d"
$FILE_NAME="backup_local" + $DAY + ".dump.gz"
$FILE_PATH=Join-Path $SNOPY_BACKUP $FILE_NAME
Write-Output $FILE_PATH

mysqldump `
    -u mysql_user `
    --password=riboribo `
    -h $HOST_NAME `
    -P $PORT `
    --default-character-set=utf8 `
    --single_transaction `
    --max_allowed_packet=200M `
    --column-statistics=0 `
    --add_drop_table snodb > $FILE_PATH