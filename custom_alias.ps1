
Set-Alias -Name pp -Value $PROFILE
Set-Alias -Name pt -Value poetry

Set-Alias -Name c -Value _code_alias
Set-Alias -Name e -Value _explorer_alias
Set-Alias -Name o -Value _obsidian_alias

function _obsidian_alias () {
    _ctrl_l_console
    $p = (_get_map address.conf)["OBS_EXE_DIR"]
    powershell.exe $(_rep_path_alias $p)
}

function _code_alias() { code . }
function _explorer_alias() { explorer . }

">>$($MyInvocation.ScriptName)"