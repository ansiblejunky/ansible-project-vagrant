$ErrorActionPreference = "Stop"

Write-Host "List all listeners ... "
winrm enumerate winrm/config/Listener

Write-Host "hostname..."
hostname

Write-Host "winrm status ... "
(Get-Service -Name winrm).Status

Write-Host "Powershell version ..."
$PSVersionTable.PSVersion

Write-Host "Win32_OperatingSystem info..."
get-wmiobject -class Win32_OperatingSystem 

Write-Host "Win32_Product info..."
Get-WmiObject Win32_Product `
  | Sort-Object -Property Name `
  | Format-Table IdentifyingNumber, Name, LocalPackage -AutoSize


exit 0
