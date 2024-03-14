
$base = $args[0]
$opts = $args[1]
$oper = $args[2]
# echo $opts

$fi = "*" + $opts + "*"

switch ($base) {
    "rust" { $p = "D:\RustRoot\" }
    "pyto" { $p = "D:\00-Pyto\" }
    "ps" {
        $p = (Get-item $profile).DirectoryName
        # echo $p
        $p = (Get-item $p).Parent.FullName
        $oper = $opts
        $fi = "WindowsPowerShell"
    }
}

# $ex = @("*test*", "*_*")

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
    foreach ( $e in $res ) {
        Resolve-Path $e.FullName
        # Write-Output $res
    }
}
