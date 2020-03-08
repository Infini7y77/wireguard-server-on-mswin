# PowerShell script
#  - must run powershell with admin privilege
#
# by: harland.coles@energy-x.com
# licence: https://opensource.org/licenses/MIT with Copyright 2020 H.R.Coles

# INPUT ARGS:
Param (
	[string]$ifname = $(throw "-ifname is required."),
	[bool]$enable = $true,
	[string]$basedir = "C:\wireguard"
)

if ($enable){
	# Update Network Profile to 'Private'
	$NetworkProfile = Get-NetConnectionProfile -InterfaceAlias $ifname
	$NetworkProfile.NetworkCategory = "Private"
	Set-NetConnectionProfile -InputObject $NetworkProfile

	sleep -Seconds 2
}

# Setup Network Sharing
Import-Module -Name $basedir\netconnectshare.psm1

Set-NetConnectionSharing $ifname $enable

#eof
