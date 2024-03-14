# run_py.ps1 main

$file = $args[0]

$curr = Get-Location
$run_dir = $curr.Path + "\py-app\" + "$($file).py"

Invoke-Expression ". $profile venv"
# iex ".\02-active_venv.ps1"
# powershell -nologo -Command ".\02-active_venv.ps1"

# Set-Location $run_dir
python $run_dir

Set-Location $curr

deactivate
