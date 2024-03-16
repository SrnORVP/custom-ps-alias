
function _get_file {
    param (
        [string]
        $config
    )
    $f = _pd | ForEach-Object {$_ + "\" + $config}
    $dirMap = Get-Content -raw $f | ConvertFrom-StringData

    return $dirMap
}

function _done {
    Write-Output "Done"
}

"Imported from '$($MyInvocation.ScriptName)'"