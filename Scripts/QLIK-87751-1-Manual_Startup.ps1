<#
Initialze and set services to manual
#>
# Config:
#Requires -RunAsAdministrator
$server1 = 'qlikserver1.domain.local'
$server2 = 'qlikserver2.domain.local'
$server3 = 'qlikserver3.domain.local'
$server3 = 'qlikserver4.domain.local'

# Set StartupType to Manual on server1
$qliksenseservice = Get-Service -Name Qlik* -ComputerName $server1
foreach ($service in $qliksenseservice ) {
    Get-Service -Name $qliksenseservice.Name -ComputerName $server1 | Set-Service -StartupType Manual  
}
# Repeat on server2
$qliksenseservice = Get-Service -Name Qlik* -ComputerName $server2
foreach ($service in $qliksenseservice ) {
    Get-Service -Name $qliksenseservice.Name -ComputerName $server2 | Set-Service -StartupType Manual  
}
# Repeat on server3
$qliksenseservice = Get-Service -Name Qlik* -ComputerName $server3
foreach ($service in $qliksenseservice ) {
    Get-Service -Name $qliksenseservice.Name -ComputerName $server3 | Set-Service -StartupType Manual  
}
# Repeat on server4
$qliksenseservice = Get-Service -Name Qlik* -ComputerName $server4
foreach ($service in $qliksenseservice ) {
    Get-Service -Name $qliksenseservice.Name -ComputerName $server4 | Set-Service -StartupType Manual  
}
