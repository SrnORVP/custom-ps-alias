# 12Mar24

$opt = $args[0]

# $curr = Get-Location
# $run_dir = $curr.Path + "\src\"

# Set-Location $run_dir

if ($opt -eq "-d") {
    cargo tauri dev
} elseif ($opt -eq "-b") {
    cargo tauri build
} else {
    cargo tauri dev
}

# Set-Location $curr
