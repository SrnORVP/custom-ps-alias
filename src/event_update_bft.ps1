
function _get_key_code () {
    Add-Type -AssemblyName System.Windows.Forms

    $Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
    public static extern short GetAsyncKeyState(int virtualKeyCode);
'@
    Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi

    do {

        foreach ($keyVal in 0..600) {
            if ([PsOneApi.Keyboard]::GetAsyncKeyState($keyVal) -eq -32767) {
                $pressed = [System.Windows.Forms.Keys]$keyVal
                echo $([string]$pressed + ", " + $keyVal)
            }

        }

        Start-Sleep -Milliseconds 100

    } while ($true)

    # 0..50 | ForEach-Object { '{0} = {1}' -f $_, [System.Windows.Forms.Keys]$_ }

    # Add-Type -AssemblyName System.Windows.Forms
    # [int][System.Windows.Forms.Keys]::ControlKey
}


function _keypress () {
    $shift_num = '16'
    $d3_num = '51'
    $d_num = '68'

    # $key = [Byte][Char]'I' ## Letter
    # $key2 = '17' ## Ctrl
    # $key3 = '18' ## Alt
    $Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
    public static extern short GetAsyncKeyState(int virtualKeyCode);
'@
    Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
    do {

        if ([PsOneApi.Keyboard]::GetAsyncKeyState($shift_num) -eq -32767 -and (-Not $k1)) {
            $k1 = $true
            Write-Host "true"
        } else {
            $k1 = $false
            Write-Host "false"
        }

        if ([PsOneApi.Keyboard]::GetAsyncKeyState($d3_num) -eq -32767) {
            $k2 = $true
        }
        if ([PsOneApi.Keyboard]::GetAsyncKeyState($d_num) -eq -32767) {
            $k3 = $true
        }

        if ($k1 -and $k2 -and $k3) {
            Write-Host "You pressed all"
            $k1 = $false
            $k2 = $false
            $k3 = $false
        }
        Start-Sleep -Milliseconds 50

    } while ($true)
}


Clear-Host
# _get_key_code
_keypress
