(Get-ChildItem $profile).DirectoryName + "\custom_cmdlet.ps1" | Import-Module


function _beeftext_date {
    $map = _get_map address.conf
    $p = $map["BFT_COMB_DIR"]
    $p = (get-item $p).FullName

    $snip_hash = @{}
    $snip_hash["#F"] = Get-Date -UFormat "%y'%m'%d-"
    $snip_hash["#D"] = Get-Date -UFormat "%d%b%y"

    $ob = Get-Content -Raw $p | ConvertFrom-Json
    $co = $ob.combos

    foreach ($elem in  $co) {
        $val = $snip_hash[$elem.keyword]
        if ($null -ne $val) {
            $elem.snippet = $val
        }
    }
    ConvertTo-Json $ob | Set-Content $p
}

function _beeftext_update {
    $map = _get_map address.conf
    $p = $map["BFT_COMB_DIR"]
    $p = (get-item $p).FullName

    $ob = Get-Content -Raw $p | ConvertFrom-Json
    $co = $ob.combos

    do {
        $snip_hash = @{}
        $snip_hash["#FF"] = Get-Date -UFormat "%y%m%d'%H%M%S-"

        foreach ($elem in  $co) {
            $val = $snip_hash[$elem.keyword]
            if ($null -ne $val) {
                $elem.snippet = $val
            }
        }
        ConvertTo-Json $ob | Set-Content $p

        _start_beeftext
        Write-Output "Updated at $(Get-Date -UFormat "%H:%M:%S")"
        Start-Sleep -Milliseconds 300000
    } while ($true)
}


function _start_beeftext () {
    $map = _get_map address.conf
    $b = $map["BFT_DIR"]
    $b = (get-item $b).FullName

    try { Stop-Process -Name "Beeftext" -ErrorAction Stop }
    catch [Microsoft.PowerShell.Commands.ProcessCommandException] { "No existing Beeftext, skipping." }
    Start-Process -FilePath $b
}


_beeftext_date
_beeftext_update
