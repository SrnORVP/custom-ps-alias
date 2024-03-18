
$map = _get_map address.conf

$p = $map["PYO3_DIR"]
$Env:Path =  $p + ";" + $Env:Path
$Env:PYO3_PYTHON = $p + "\python.exe"

$ps = $Env:Path -split ";"

Write-Output "PYO3 env: $Env:PYO3_PYTHON"
Write-Output "paths.count: $($ps.count)"
Write-Output "path[0]: $($ps[0])"
""