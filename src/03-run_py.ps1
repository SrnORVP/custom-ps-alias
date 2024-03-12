# 12Mar24
# run_py.ps1 main

$file = $args[0]

$curr = Get-Location
$run_dir = $curr.Path + "\py-app\"

Invoke-Expression ". $profile venv"
# iex ".\02-active_venv.ps1"
# powershell -nologo -Command ".\02-active_venv.ps1"

Set-Location $run_dir

python ".\$($file).py"

Set-Location $curr

deactivate
