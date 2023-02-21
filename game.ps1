#Requires -Version 5.1
Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

if ([System.Environment]::OSVersion.Platform -ne "Win32NT") {
    throw "This script only supports Windows!"
}

$tmpFile = "$env:TMP/windows.zip"
$localAppsDir = [System.IO.Path]::GetFullPath("$env:LOCALAPPDATA/Programs/pong-bullet-heaven")
$startMenuDir = [System.Environment]::GetFolderPath("Programs")
$lnk = [System.IO.Path]::Combine($startMenuDir, "Pong Bullet Heaven.lnk")

Invoke-RestMethod -OutFile $tmpFile "https://github.com/pong-bullet-heaven/pong-bullet-heaven/releases/download/latest/windows.zip"

if (Test-Path $localAppsDir) {
    Remove-Item -Recurse -Force $localAppsDir
}

Expand-Archive -Path $tmpFile -DestinationPath $localAppsDir
Remove-Item -Force $tmpFile

$exe = Get-ChildItem -File -Filter "*.exe" $localAppsDir | Select-Object -First 1

if (!(Test-Path -PathType Leaf $exe)) {
    throw "Couldn't find the game exe"
}

if (Test-Path $lnk) {
    Remove-Item $lnk
}

$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($lnk)
$shortcut.TargetPath = $exe.FullName
$shortcut.WorkingDirectory = $exe.DirectoryName
$shortcut.Save()
