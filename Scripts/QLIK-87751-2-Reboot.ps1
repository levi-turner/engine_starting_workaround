<#
Initialze and set services to Automatic
#>
#Requires -RunAsAdministrator
$server1 = 'qlikserver1.domain.local'
$server2 = 'qlikserver2.domain.local'
$server3 = 'qlikserver3.domain.local'
$server3 = 'qlikserver4.domain.local'

# Startup on the Central
Get-Service -Name QlikSenseRepositoryDatabase -ComputerName $server1 | Start-Service
Get-Service -Name QlikLoggingService -ComputerName $server1 | Start-Service
Get-Service -Name QlikSenseServiceDispatcher -ComputerName $server1 | Start-Service
Start-Sleep 10
Get-Service -Name QlikSenseRepositoryService -ComputerName $server1 | Start-Service
# Loop the logs:
$qrsalive = ''
Do {
    if($($qrsalive) -eq 'Ping successful.') {Write-Host "Qlik Sense Repository is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qrsalive = Invoke-RestMethod -Uri "https://$($server1):4242/ssl/ping?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qrsalive) -eq 'Ping successful.')
Get-Service -Name QlikSenseSchedulerService -ComputerName $server1 | Start-Service
Get-Service -Name QlikSenseProxyService -ComputerName $server1 | Start-Service
# Loop on Proxy being up
$qpsalive = ''
Do {
    if($($qpsalive.value) -eq 'true') {Write-Host "Qlik Sense Proxy is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qpsalive = Invoke-RestMethod -Uri "https://$($server1):4243/qps/alive?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qpsalive.value) -eq 'true')
Get-Service -Name QlikSensePrintingService -ComputerName $server1 | Start-Service
Get-Service -Name QlikSenseEngineService -ComputerName $server1 | Start-Service

# Startup on server2
foreach ($Server in $server2) 
{
    while ( (get-service -Name lanmanserver -ComputerName $Server).Status -ne "Running" ) {
LogWrite "Waiting for $Server ..."
        Start-Sleep -s 15
    }
LogWrite "$Server is Up!"

}
Get-Service -Name QlikLoggingService -ComputerName $server2 | Start-Service
Get-Service -Name QlikSenseServiceDispatcher -ComputerName $server2 | Start-Service
Start-Sleep 10
Get-Service -Name QlikSenseRepositoryService -ComputerName $server2 | Start-Service
# Loop the logs:
$qrsalive = ''
Do {
    if($($qrsalive) -eq 'Ping successful.') {Write-Host "Qlik Sense Repository is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qrsalive = Invoke-RestMethod -Uri "https://$($server2):4242/ssl/ping?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qrsalive) -eq 'Ping successful.')
Get-Service -Name QlikSenseSchedulerService -ComputerName $server2 | Start-Service
Get-Service -Name QlikSenseProxyService -ComputerName $server2 | Start-Service
# Loop on Proxy being up
$qpsalive = ''
Do {
    if($($qpsalive.value) -eq 'true') {Write-Host "Qlik Sense Proxy is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qpsalive = Invoke-RestMethod -Uri "https://$($server2):4243/qps/alive?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qpsalive.value) -eq 'true')
Get-Service -Name QlikSensePrintingService -ComputerName $server2 | Start-Service
Get-Service -Name QlikSenseEngineService -ComputerName $server2 | Start-Service

# Start server3
foreach ($Server in $server3) 
{
    while ( (get-service -Name lanmanserver -ComputerName $Server).Status -ne "Running" ) {
LogWrite "Waiting for $Server ..."
        Start-Sleep -s 15
    }
LogWrite "$Server is Up!"

}
Get-Service -Name QlikLoggingService -ComputerName $server3 | Start-Service
Get-Service -Name QlikSenseServiceDispatcher -ComputerName $server3 | Start-Service
Start-Sleep 10
Get-Service -Name QlikSenseRepositoryService -ComputerName $server3 | Start-Service
# Loop the logs:
$qrsalive = ''
Do {
    if($($qrsalive) -eq 'Ping successful.') {Write-Host "Qlik Sense Repository is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qrsalive = Invoke-RestMethod -Uri "https://$($server3):4242/ssl/ping?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qrsalive) -eq 'Ping successful.')
Get-Service -Name QlikSenseSchedulerService -ComputerName $server3 | Start-Service
Get-Service -Name QlikSenseProxyService -ComputerName $server3 | Start-Service
# Loop on Proxy being up
$qpsalive = ''
Do {
    if($($qpsalive.value) -eq 'true') {Write-Host "Qlik Sense Proxy is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qpsalive = Invoke-RestMethod -Uri "https://$($server3):4243/qps/alive?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qpsalive.value) -eq 'true')
Get-Service -Name QlikSensePrintingService -ComputerName $server3 | Start-Service
Get-Service -Name QlikSenseEngineService -ComputerName $server3 | Start-Service

# Start server4
foreach ($Server in $server4) 
{
    while ( (get-service -Name lanmanserver -ComputerName $Server).Status -ne "Running" ) {
LogWrite "Waiting for $Server ..."
        Start-Sleep -s 15
    }
LogWrite "$Server is Up!"

}
Get-Service -Name QlikLoggingService -ComputerName $server4 | Start-Service
Get-Service -Name QlikSenseServiceDispatcher -ComputerName $server4 | Start-Service
Start-Sleep 10
Get-Service -Name QlikSenseRepositoryService -ComputerName $server4 | Start-Service
# Loop the logs:
$qrsalive = ''
Do {
    if($($qrsalive) -eq 'Ping successful.') {Write-Host "Qlik Sense Repository is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qrsalive = Invoke-RestMethod -Uri "https://$($server4):4242/ssl/ping?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qrsalive) -eq 'Ping successful.')
Get-Service -Name QlikSenseSchedulerService -ComputerName $server4 | Start-Service
Get-Service -Name QlikSenseProxyService -ComputerName $server4 | Start-Service
# Loop on Proxy being up
$qpsalive = ''
Do {
    if($($qpsalive.value) -eq 'true') {Write-Host "Qlik Sense Proxy is alive" | Out-Null}
    else{
    start-sleep 5
    $hdrs = @{}
    $hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
    $hdrs.Add("X-Qlik-User", "UserDirectory=INTERNAL; UserId=sa_api")
    $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' 
    $qpsalive = Invoke-RestMethod -Uri "https://$($server4):4243/qps/alive?xrfkey=examplexrfkey123" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
    }
}
Until($($qpsalive.value) -eq 'true')
Get-Service -Name QlikSensePrintingService -ComputerName $server4 | Start-Service
Get-Service -Name QlikSenseEngineService -ComputerName $server4 | Start-Service