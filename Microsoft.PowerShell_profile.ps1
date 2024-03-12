# 12Mar24

# simulate ctrl-L instead of Clear-Host
Write-Output ("`n" * ($Host.UI.RawUI.WindowSize.Height - 3))
$e = [char]27
# Move cursor to 0;0
Write-Output "$e[H"
# Erase down/right
Write-Output "$e[J"


$opts = $args[0]
# Write-Output $opts

$orig = Get-Location
$mypf = (Get-item $profile).DirectoryName

if ($args.Count -gt 1) {
    $pass = $args[1..$args.Count] -join ' '
}
else {
    $pass = ''
}

switch ($opts) {
    "venv" {
        $scpt = '\src\02-active_venv.ps1 '
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
        Set-Location $orig
    }
    "rust" {
        $scpt = "\src\05-run_rust.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
        Set-Location $orig
    }
}

if ($opts -eq "venv") {
    $scpt = '\src\02-active_venv.ps1 '
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    # Invoke-Expression $com
    # Set-Location $orig
}

elseif ($opts -eq "rust") {
    $scpt = "\src\05-run_rust.ps1 "
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    Invoke-Expression $com
    Set-Location $orig
}

elseif ($opts -eq "pyo3") {
    $scpt = "\src\01-setup_pyo3.ps1 "
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    Invoke-Expression $com
    Set-Location $orig
}

elseif ($opts -eq "py") {
    $scpt = "\src\03-run_py.ps1 "
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    Invoke-Expression $com
    Set-Location $orig
}

elseif ($opts -eq "pyt") {
    $scpt = "\src\04-test_py.ps1 "
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    Invoke-Expression $com
    Set-Location $orig
}

elseif ($opts -eq "cd") {
    $scpt = "\src\06-change_dir.ps1 "
    $com = $mypf + $scpt + $pass
    # Write-Output $com
    Invoke-Expression $com
}

elseif ($opts -eq "dev") {
    Write-Output $args.Count

    $scpt = '\src\00-dev.ps1 '
    $com = $mypf + $scpt + $pass
    # Write-Output $orig
    # Write-Output $mypf
    # Write-Output $com

    Set-Location $mypf
    Invoke-Expression $com
    Set-Location $orig
}

