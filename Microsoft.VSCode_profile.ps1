Set-StrictMode -Version Latest

function _gd {
    param (
        [string]
        $scriptFile
    )
    return ((Get-ChildItem $profile).DirectoryName + $scriptFile)
}

_gd ".\custom_cmdlet.ps1" | Import-Module
_gd ".\src\get_file.ps1" | Import-Module

