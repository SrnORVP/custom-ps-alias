
function _get_map {
    param (
        [string]
        $filepath
    )
    $f = _get_profile_file $filepath
    $dirMap = Get-Content -raw $f | ConvertFrom-StringData

    return $dirMap
}

function _done {
    Write-Output "Done"
}

function _get_p_path {
    return (Get-ChildItem $profile).DirectoryName
}

function _get_profile_file {
    param (
        [string]
        $scriptFile
    )
    $p = _get_p_path

    $fi = "*" + $scriptFile + "*"
    $res = (Get-ChildItem -Path $p -File -Depth 2 -Filter $fi)
    # $res

    if ($null -eq $res) {
        Write-Output "None found."
    }
    else {
        $res = $res.FullName
        # $res
        # $res.GetType()

        if ($res -is [string]) {
            return $res
        }
        else {
            Write-Output "more than 1 path found, returned the first one"
            Write-Output "--------------------------------------------"
            $res
        }
        return  $res[0]
    }
}



"Module Imported from '$($MyInvocation.ScriptName)'"
""