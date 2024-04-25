# Set-StrictMode -Version Latest

function _ctrl_l_console() {
    # simulate ctrl-L instead of Clear-Host
    Write-Output ("`n" * ($Host.UI.RawUI.WindowSize.Height - 4))
    $e = [char]27
    # Move cursor to 0;0
    Write-Output "$e[H"
    # Erase down/right
    Write-Output "$e[J"
}

function _get_map {
    param (
        [string]
        $filepath
    )
    $f = _get_profile_file $filepath
    return = Get-Content -raw $f | ConvertFrom-StringData
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

    if ($null -eq $res) {
        Write-Output "None found."
    }
    else {
        $res = $res.FullName

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