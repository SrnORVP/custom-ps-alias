
$base = $args[0]
$opts = $args[1]
$oper = $args[2]
# echo $opts

$fi = "*" + $opts + "*"

$map = _get_map address.conf

switch ($base) {
    "rust" { $p = $map["RUST_DIR"] }
    "pyto" { $p = $map["PYTO_DIR"] }
    "app" {$p = $map["APP_DIR"] }
    "ps" {
        $p = _get_p_path
        $p = (Get-item $p).Parent.FullName
        # echo $p
        $oper = $opts
        $fi = "WindowsPowerShell"
    }
}

$res = (Get-ChildItem -Path $p -Directory -Depth 2 -Filter $fi)

if ($res.Count -eq 1) {
    Write-Output "---------------------------------"
    Write-Output "Matched and moved"
    Resolve-Path $res.FullName
    Write-Output "---------------------------------"
    Set-Location $res.FullName

    switch ($oper) {
        "-c" {code . }
        "-code" {code . }
        "-e" {explorer . }
        "-expl" {explorer . }
    }
}
elseif ($res.Count -eq 0) {
    Write-Output "None found."
}
else {
    Write-Output "More than one found, not moved."
    Write-Output "---------------------------------"
    foreach ( $e in $res ) {
        Resolve-Path $e.FullName
        # Write-Output $res
    }
}
