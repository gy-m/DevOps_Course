# mytask_runner.ps1  -TaskName "genady" -SecToWait 15

param([parameter(Mandatory)] [String] $TaskName,
        [parameter(Mandatory)] [int] $SecToWait)


function Create-Task {
    param (
        [parameter(Mandatory, Position=0)][String]$task_name,
        [parameter(Mandatory, Position=1)][String]$exe_path
        )

    # How to make task action less than a Minute
    $task_action = New-ScheduledTaskAction -Execute "powershell" -Argument $exe_path
    $task_trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
    $task_principal = New-ScheduledTaskPrincipal -UserID "LOCALSERVICE" -LogonType ServiceAccount
    $task_settings = New-ScheduledTaskSettingsSet
    $task_defenition = New-ScheduledTask -Action $task_action -Principal $task_principal -Trigger $task_trigger -Settings $task_settings
    Register-ScheduledTask -TaskName $task_name -Trigger $task_trigger -User "gymaky@gmail.com" -Action $task_action

    # Register-ScheduledTask T1 -InputObject $task_defenition
    # todo - delete it:
    Write-Host $task_action
    Write-Host $task_trigger
    Write-Host $task_principal
    Write-Host $task_settings
    Write-Host $task_defenition
}

function Change-TaskStatus {
    param (
        [parameter(Mandatory, Position=0)][String]$task_name,
        [parameter(Mandatory, Position=1)][int]$sec_to_wait
        )

    # This will effect the PS window also
    Start-Sleep $sec_to_wait
    Disable-ScheduledTask -TaskName $task_name
}

function Get-AllTasks{
    $tasks = Get-ScheduledTask

    foreach ($task in $tasks) {
        Write-Host $task.TaskName
        # Write-Host $task.TaskPath

    }

    # Write-Host $tasks[0]
}

$task_name = $TaskName
$sec_to_wait = $SecToWait
Create-Task $task_name "C:\Users\User\Temp\Project_02\mytask.ps1"
Change-TaskStatus $task_name $sec_to_wait
Get-AllTasks

# debug
# $task_name = "my_task"
# $sec_to_wait = 5        
# Create-Task $task_name "C:\Users\User\Temp\Project_02\mytask.ps1"
# Change-TaskStatus $task_name $sec_to_wait
# Get-AllTasks