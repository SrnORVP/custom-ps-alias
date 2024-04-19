
(Get-ChildItem $profile).DirectoryName + ".\custom_cmdlet.ps1" | Import-Module
(Get-ChildItem $profile).DirectoryName + ".\custom_user_cmd.ps1" | Import-Module
""

# Capture the command for intentional calls
if ($args.Count -eq 0) { $opts = "" } else {
    $opts = $args[0]
    # Write-Output $opts

    $orig = Get-Location
    $mypf = (Get-item $profile).DirectoryName

    # simulate ctrl-L instead of Clear-Host
    Write-Output ("`n" * ($Host.UI.RawUI.WindowSize.Height - 4))
    $e = [char]27
    # Move cursor to 0;0
    Write-Output "$e[H"
    # Erase down/right
    Write-Output "$e[J"

    if ($args.Count -eq 1) {
        $pass = ''
    }
    else {
        $e = $args.Count - 1
        $pass = $args[1..$e] -join ' '
    }
}


switch ($opts) {
    { $_ -in "pyv", "venv" } { Invoke-Expression "_setup_venv" }

    { $_ -in "rs", "rust" } {
        $scpt = "\src\05-run_rust.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    { $_ -in "ta", "tauri" } { Invoke-Expression "_invoke_tauri $pass" }

    { $_ -in "pyo", "pyo3" } { Invoke-Expression "_setup_pyo $pass" }

    { $_ -in "py", "pyr" , "pyrun" } {
        $scpt = "\src\03-run_py.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    { $_ -in "pyt", "pytest" } {
        $scpt = "\src\04-test_py.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    { $_ -in "cd", "change" } {
        $scpt = "\src\06-change_dir.ps1 "
        $com = $mypf + $scpt + $pass
        # Write-Output $com
        Invoke-Expression $com
    }

    { $_ -in "obs", "obsidian" } { Invoke-Expression "_run_obsidian $pass" }

    # { $_ -in "dev" } {
    #     Get-Module dev | Remove-Module
    #     (Get-ChildItem $profile).DirectoryName + ".\dev.ps1" | Import-Module
    #     _run_dev
    # }
}
