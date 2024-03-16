
Set-Alias -Name ppp -Value $PROFILE

# Capture the command for intentional calls
if ($args.Count -eq 0) { $opts = "" } else {
    $opts = $args[0]
    # Write-Output $opts

    $orig = Get-Location
    $mypf = (Get-item $profile).DirectoryName

    # simulate ctrl-L instead of Clear-Host
    Write-Output ("`n" * ($Host.UI.RawUI.WindowSize.Height - 3))
    $e = [char]27
    # Move cursor to 0;0
    Write-Output "$e[H"
    # Erase down/right
    Write-Output "$e[J"

    if ($args.Count -eq 1) {
        $pass = ''
    }
    else {
        $pass = $args[1..$args.Count] -join ' '
    }
}


switch ($opts) {
    "venv" {
        $scpt = '\src\02-active_venv.ps1 '
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "rs" {
        $scpt = "\src\05-run_rust.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "rust" {
        $com = ".`$PROFILE rs " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "ta" {
        $scpt = "\src\07-tauri_rust.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "tauri" {
        $com = ".`$PROFILE ta " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }


    "pyo" {
        $scpt = "\src\01-setup_pyo3.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "pyo3" {
        $com = ".`$PROFILE pyo " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "py" {
        $scpt = "\src\03-run_py.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "pyr" {
        $com = ".`$PROFILE py " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "pyrun" {
        $com = ".`$PROFILE py " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "pyt" {
        $scpt = "\src\04-test_py.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }
    "pytest" {
        $com = ".`$PROFILE pyt " + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "cd" {
        $scpt = "\src\06-change_dir.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    "dev" {
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
}
