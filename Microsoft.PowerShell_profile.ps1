Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord Alt+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function ForwardWord
Set-PSReadLineOption -Colors @{
    Parameter = 'Magenta'
    Command = 'Cyan'
    String = 'Cyan'
    Operator = 'White'
    Member = 'White'
    Type = 'White'
}

$env:_ZO_EXCLUDE_DIRS = ""

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (& { (tv init power-shell | Out-String) })
Set-Alias -Name ls -Value eza
$env:EDITOR = "nvim"

function y
{
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
    {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

Set-Alias -Name lg -Value lazygit

function gpr
{
    git pull --rebase
}

function reloadpath
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

$env:TELEVISION_CONFIG = (Resolve-Path "~\.config\television")

function wi
{
    param (
        $query
    )
    Find-WinGetPackage $query | Out-GridView -OutputMode Single | Install-WinGetPackage
}


function wr
{
    Get-WinGetPackage | Out-GridView -OutputMode Multiple | Uninstall-WinGetPackage
}
