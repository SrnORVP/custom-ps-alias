# Set-StrictMode -Version Latest

Set-Alias -Name pp -Value $PROFILE
Set-Alias -Name c -Value _code_alias
Set-Alias -Name e -Value _explorer_alias
Set-Alias -Name pt -Value poetry

function _code_alias() { code . }
function _explorer_alias() { explorer.exe . }

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

function _get_root {
    $p = $(Get-Location).Path
    # $p = $($MyInvocation.PSScriptRoot)
    return $p

}

function _get_profile_file {
    param (
        [switch] $d,
        [string] $File
    )
    if ($d) {
        $p = _get_root
    }
    else {
        $p = _get_p_path
    }

    $fi = "*" + $File + "*"
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



function _get_env_paths {
    ($env:path) -split ";"
    Get-ChildItem env:
}

function _rep_path_alias {
    param (
        [string] $File
    )

    $a = $File.Split("%")

    if ($a.Count -eq 3) {
        $ep = (Get-Item $a[1])[0].value
        return $ep + $a[2]
    }
    elseif ($a.Count -eq 1) {
        return $File
    }
    else {
        "Support only one env as surrounded %"
    }
}

">>$($MyInvocation.ScriptName)"