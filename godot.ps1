param ([string] $file = $null)

#Requires -Version 5.1
Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

if ([System.Environment]::OSVersion.Platform -ne "Win32NT") {
    throw "This script only supports Windows!"
}

function GetFileDialog {
    Add-Type -AssemblyName "System.Windows.Forms"
    $fileDialog = [System.Windows.Forms.OpenFileDialog]::new()
    $fileDialog.InitialDirectory = $homeDir
    $fileDialog.Multiselect = $false
    $fileDialog.ShowDialog() > $null
    $file = $fileDialog.FileName
    return $file
}

$homeDir = [System.Environment]::GetFolderPath("UserProfile")
$tmpDir = [System.IO.Path]::GetFullPath("$env:TMP/Godot")
$localAppsDir = [System.IO.Path]::GetFullPath("$env:LOCALAPPDATA/Programs/Godot")
$startMenuDir = [System.Environment]::GetFolderPath("Programs")
$lnk = [System.IO.Path]::Combine($startMenuDir, "Godot.lnk")

if (!$file) {
    Write-Output "Opening download page of Godot"
    Write-Output "Please download Godot for your platform and select the downloaded file in this prompt"
    Start-Process "https://godotengine.org/download/windows/"
    $file = GetFileDialog

    if (!$file) {
        throw "Invalid path to godot archive"
    }
}

if (Test-Path $tmpDir) {
    Remove-Item -Recurse -Force $tmpDir
}

Expand-Archive -Path $file -DestinationPath $tmpDir
$exe = Get-ChildItem -Recurse -File -Filter "*.exe" $tmpDir | Select-Object -First 1
if (!$exe) {
    throw "Couldn't find the godot exe"
}

if (Test-Path $localAppsDir) {
    Remove-Item -Recurse -Force $localAppsDir
}

Move-Item $exe.Directory $localAppsDir

if (Test-Path $tmpDir) {
    Remove-Item -Recurse -Force $tmpDir
}

$exe = Get-ChildItem -File -Filter "*.exe" $localAppsDir | Select-Object -First 1

if (!$exe) {
    throw "Couldn't find the godot exe"
}

if (Test-Path $lnk) {
    Remove-Item $lnk
}

$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($lnk)
$shortcut.TargetPath = $exe.FullName
$shortcut.WorkingDirectory = $exe.DirectoryName
$shortcut.Save()
