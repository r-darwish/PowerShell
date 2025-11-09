Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord Alt+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function ForwardWord

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
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
