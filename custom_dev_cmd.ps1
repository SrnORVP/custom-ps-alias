# Set-StrictMode -Version Latest

function _invoke_tauri {
    param (
        [switch] $d,
        [switch] $b
    )

    if ($d) {
        cargo tauri dev
    }
    elseif ($b) {
        cargo tauri build
    }
    else {
        cargo tauri dev
    }

}

function _setup_pyo {
    param (
        [switch] $v
    )
    $p = (_get_map address.conf)["PYO3_DIR"]

    $Env:Path = $p + ";" + $Env:Path
    $Env:PYO3_PYTHON = $p + "\python.exe"
    $ps = $Env:Path -split ";"

    if ($v) {
        Write-Output "PYO3_env: $Env:PYO3_PYTHON"
        Write-Output "path.cnt: $($ps.count)"
        Write-Output "path[0]: $($ps[0])"
    }
}

"Module Imported from '$($MyInvocation.ScriptName)'"


