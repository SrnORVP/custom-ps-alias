Set-StrictMode -Version Latest

(Get-ChildItem $profile).DirectoryName + ".\custom_cmdlet.ps1" | Import-Module


$fp = _get_profile_file "address"
$fp = _get_profile_file address.conf
$fp


$dir_map = _get_map address.conf
$dir_map


$base = "ps"


