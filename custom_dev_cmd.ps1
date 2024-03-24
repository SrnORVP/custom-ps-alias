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


"Module Imported from '$($MyInvocation.ScriptName)'"