
$opt = $args[0]
$curr = Get-Location
$fi = "Cargo.toml"

$res = (Get-ChildItem -Path $p -File -Depth 2 -Filter $fi)
if ($res.count -eq 1) {
    $run_dir = $res.Directory.FullName
    Set-Location $run_dir

    if ($opt -eq "-c") {
        cargo check
    }
    elseif ($opt -eq "-b") {
        cargo build -r
    }
    elseif ($opt -eq "-t") {
        cargo test
    }
    else {
        cargo run dev
    }

    Set-Location $curr
}
else {
    Write-Output "Found $($res.count) ea. of '$fi' in '$p'"
}

