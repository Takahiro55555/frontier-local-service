$scriptPath = "C:\RPGLocalDocker\mysql\db_backup.ps1"

$task=New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-executionpolicy bypass -noprofile -file $scriptPath" 
$trigger=New-ScheduledTaskTrigger -Daily -At 22:00:00
Register-ScheduledTask -TaskName "BackupSnopyDataBase" -Trigger $trigger -Action $task -User "System"