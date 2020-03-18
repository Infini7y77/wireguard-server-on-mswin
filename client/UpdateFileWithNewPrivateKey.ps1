# PowerShell script
#
# by: harland.coles@energy-x.com
# licence: https://opensource.org/licenses/MIT with Copyright 2020 H.R.Coles
#
# Generate a new random private key and update a file by search / replace
# Note: Replace uses regex matching, need to escape for literals

# INPUT ARGS:
Param (
    [string]$filepath = $(throw "-filepath is required."),
    [string]$match_text = 'Dont\+Use\+This\+As\+Your\+Real\+PrivateKey\+10001\='
)

Add-Type -AssemblyName System.Security
[Reflection.Assembly]::LoadWithPartialName("System.Security")

# Generate a new random key and base64 encode
$rijndael = new-Object System.Security.Cryptography.RijndaelManaged
$rijndael.GenerateKey()
$new_key = [Convert]::ToBase64String($rijndael.Key)
$rijndael.Dispose()

# Replace key in file with new random key
(Get-Content -Path $filepath) -replace $match_text, $new_key | Set-Content -Path "$filepath" -Force

#eof
