# 12Mar24
# test_py.ps1 -m [marker]
# test_py.ps1 -dbg

if ($args[0] -eq "-dbg") {
    $selected = $args[1..$args.Count] -join ' '
    # $passthru = $selected + " --capture no --color yes"
    $passthru = $selected + " --capture tee-sys --color yes"

} else {
    $passthru = $args -join ' '
}

$curr = Get-Location
# $test_dir = $curr.Path + '\src-tauri' + '\py-app'
$test_dir = $curr.Path

$com = (Get-item $profile).DirectoryName + '\02-active_venv.ps1 '
Invoke-Expression $com

# Invoke-Expression ". $profile venv"
# powershell -nologo -Command ".\02-active_venv.ps1"

Set-Location $test_dir

$command = "pytest " + $passthru
# echo $command
powershell -nologo -Command $command

Set-Location $curr
deactivate

