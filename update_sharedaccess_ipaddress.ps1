# PowerShell script
#  - must run powershell with admin privilege
#
# by: harland.coles@energy-x.com
# licence: https://opensource.org/licenses/MIT with Copyright 2020 H.R.Coles

# INPUT ARGS:
Param (
	[string]$ipv4addr = $(throw "-ipv4addr is required.")
)

$reg_path="HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters"
$reg_key="ScopeAddress"

$cur_ipaddr = Get-ItemProperty -Path $reg_path -Name $reg_key

# Update registry item if new IP address
if ($ipv4addr -as [IPAddress] -AND $cur_ipaddr -AND -NOT ($ipv4addr -eq $cur_ipaddr)) {
	Set-ItemProperty -Path $reg_path -Name $reg_key -Value $ipv4addr
}

#eof
