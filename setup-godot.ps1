param ([string]$file = $null)

#Requires -Version 5.1
Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"

$path = [System.IO.Path]

if (!$file) {
    Write-Information "Opening Godot download page"
    Start-Process "https://godotengine.org/download/windows/"
    Write-Information "Please download Godot and select the downloaded archive in this prompt"

    Add-Type -AssemblyName "System.Windows.Forms"
    $fileDialog = [System.Windows.Forms.OpenFileDialog]::new()
    $fileDialog.InitialDirectory = [System.Environment]::GetFolderPath("UserProfile")
    $fileDialog.Multiselect = $false
    $fileDialog.ShowDialog() > $null
    $file = $fileDialog.FileName
}

if (!$file -or !$(Test-Path -PathType Leaf $file)) {
    Write-Error "Couldn't find the godot archive!"
    exit
}

$tmpDir = $path::GetFullPath("$env:TMP/Godot")
$localAppDataDir = $path::GetFullPath("$env:LOCALAPPDATA/Godot")
$startMenuDir = [System.Environment]::GetFolderPath("Programs")
$lnkGodot = $path::Combine($startMenuDir, "Godot.lnk")

if (Test-Path $tmpDir) {
    Remove-Item -Recurse -Force $tmpDir
}

Expand-Archive -Path $file -DestinationPath $tmpDir
$exe = Get-ChildItem -Recurse -File -Filter "*.exe" $tmpDir | Select-Object -First 1
if (!$exe) {
    Write-Error "Couldn't find the godot exe in tmp!"
    exit
}

if (Test-Path $localAppDataDir) {
    Remove-Item -Recurse -Force $localAppDataDir
}

Move-Item $exe.Directory $localAppDataDir
$exe = Get-ChildItem -File -Filter "*.exe" $localAppDataDir | Select-Object -First 1

if (!$exe) {
    Write-Error "Couldn't find the godot exe in local appdata!"
    exit
}

if (Test-Path $lnkGodot) {
    Remove-Item $lnkGodot
}

$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($lnkGodot)
$shortcut.TargetPath = $exe.FullName
$shortcut.WorkingDirectory = $exe.DirectoryName
$shortcut.Save()
