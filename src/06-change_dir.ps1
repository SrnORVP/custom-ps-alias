# 12Mar24

$base = $args[0]
$opts = $args[1]
# echo $opts

$fi = "*" + $opts + "*"

switch ($base) {
    "rust" { $p = "D:\RustRoot\" }
    "pyto" { $p = "D:\00-Pyto\" }
    "ps" {
        $p = (Get-item $profile).DirectoryName
        # echo $p
        $p = (Get-item $p).Parent.FullName
        $fi = "WindowsPowerShell"
    }
}

# $ex = @("*test*", "*_*")

$res = (Get-ChildItem -Path $p -Directory -Depth 1 -Filter $fi)

if ($res.Count -eq 1) {
    Write-Output "---------------------------------"
    Write-Output "Matched and moved"
    Resolve-Path $res.FullName
    Write-Output "---------------------------------"
    Set-Location $res.FullName
}
else {
    foreach ( $e in $res ) {
        Resolve-Path $e.FullName
        # Write-Output $res
    }
}
