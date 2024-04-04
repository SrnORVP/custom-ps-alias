# run_py.ps1 main

$file = $args[0]

$curr = Get-Location
$run_dir = $curr.Path + "\py-app\" + "$($file).py"

_setup_venv -v
# Invoke-Expression ". $profile venv"

# Set-Location $run_dir
python $run_dir

Set-Location $curr

deactivate
