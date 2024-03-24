# Set-StrictMode -Version Latest

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
        [string] $File
    )
    $p = _get_p_path

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

function _beeftext_date {
    $map = _get_map address.conf
    $p = $map["BFT_COMB_DIR"]
    $b = $map["BFT_DIR"]

    $snip_hash = @{}
    $snip_hash["#F"] = Get-Date -UFormat "%d%b%y"
    $snip_hash["#D"] = Get-Date -UFormat "%y'%m'%d-"

    $ob = Get-Content -Raw $p | ConvertFrom-Json
    $co = $ob.combos

    foreach ($elem in  $co) {
        $val = $snip_hash[$elem.keyword]
        if ($null -ne $val) {
            $elem.snippet = $val
        }
    }

    ConvertTo-Json $ob | Set-Content $p
    Stop-Process -Name "Beeftext"
    Start-Process -FilePath $b
}

"Module Imported from '$($MyInvocation.ScriptName)'"