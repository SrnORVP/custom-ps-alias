
$base = $args[0]
$opts = $args[1]
$oper = $args[2]
# echo $opts

$fi = "*" + $opts + "*"

$map = _get_map address.conf

if ($base -eq "ps") {
    $p = _get_p_path
    Set-Location $p
    exit
}
else {
    $up = $base.ToUpper() + "_DIR"
    $p = $map[$up]
    $p = _rep_path_alias $p
}

if ($null -eq $opts) {
    Set-Location $p
    exit
}
else {
    $res = (Get-ChildItem -Path $p -Directory -Depth 2 -Filter $fi)
}

if ($res.Count -eq 1) {
    Write-Output "------------------------------------------------------------------"
    Write-Output "Matched and moved"
    [array] $res.FullName
    Write-Output "------------------------------------------------------------------"
    Write-Output ""
    Set-Location $res.FullName
}
elseif ($res.Count -eq 0) {
    Write-Output "None found."
}
else {
    switch -Regex ($oper) {
        "\d" {
            $p = [string] $res[$_ - 1].FullName
            Set-Location $p
        }
        Default {
            Write-Output "More than one found, not moved."
            Write-Output "------------------------------------------------------------------"
            [array] $res.FullName
            Write-Output "------------------------------------------------------------------"
            Write-Output ""
        }
    }
}
