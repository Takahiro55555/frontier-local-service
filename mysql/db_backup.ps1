$SNOPY_BACKUP="C:\Users\RPGLocal2018\iCloudDrive\backup\database_snopy"
$DAYS=7
$file_count = (Get-ChildItem $SNOPY_BACKUP | ? { ! $_.PsIsContainer }).Count

# 古いファイルの削除(10日以上前)
if( $file_count -ge $DAYS ){
    Get-ChildItem $SNOPY_BACKUP -Recurse | Where-Object {($_.Mode -eq "-a---l") -and ($_.CreationTime -lt (Get-Date).AddDays(-1 * $DAYS))} | Remove-Item -force
}

# データベースのバックアップ
$PORT=3306
$HOST_NAME="localhost"
$DAY=Get-Date -UFormat "%Y-%m-%d"
$FILE_NAME="backup_local" + $DAY + ".dump"
$FILE_PATH=Join-Path $SNOPY_BACKUP $FILE_NAME
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