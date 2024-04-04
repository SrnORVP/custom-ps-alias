# test_py.ps1 -m [marker]
# test_py.ps1 -dbg

if ($args[0] -eq "-dbg") {
    $selected = $args[1..$args.Count] -join ' '
    # $passthru = $selected + " --capture no --color yes"
    $passthru = $selected + " --capture tee-sys --color yes"

} else {
    $passthru = $args -join ' '
}
# echo $passthru


$curr = Get-Location
# $test_dir = $curr.Path + '\src-tauri' + '\py-app'
$test_dir = $curr.Path

_setup_venv -v
# $com = (Get-childitem $profile).DirectoryName + '\src\02-active_venv.ps1'
# Invoke-Expression $com

Set-Location $test_dir

$command = "pytest " + $passthru
# echo $command
powershell -nologo -Command $command

Set-Location $curr
deactivate

