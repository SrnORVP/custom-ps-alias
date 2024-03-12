# 12Mar24

$opt = $args[0]

$curr = Get-Location
$run_dir = $curr.Path + "\src\"

Set-Location $run_dir

if ($opt -eq "-c") {
    cargo check
} elseif ($opt -eq "-b") {
    cargo build -r
} else {
    cargo run dev
}

Set-Location $curr
