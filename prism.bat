@echo off

:: ===== CONFIG =====
:: Minecraft version
set version=1.20.2
:: ==================

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
echo Portable Prism Minecraft Launcher
echo =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
if not exist "%CD%\Minecraft" mkdir "%CD%\Minecraft"
if not exist "%CD%\Minecraft\temp" mkdir "%CD%\Minecraft\temp"
if not exist "%CD%\Minecraft\prismlauncher.exe" goto download
 
:launch
color 0a
echo Prism Minecraft launcher found!
echo Launching...
start "PrismLauncher" "%CD%\Minecraft\prismlauncher.exe" --launch %version%
goto end
 
:download
color 0c
echo Prism Minecraft launcher not found!
echo Downloading...
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://github.com/PrismLauncher/PrismLauncher/releases/download/8.2/PrismLauncher-Windows-MSVC-Portable-8.2.zip' '%CD%\Minecraft\temp\prism.zip'"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://download.oracle.com/java/17/archive/jdk-17.0.10_windows-x64_bin.zip' '%CD%\Minecraft\temp\java.zip'"
echo Extracting...
powershell "Expand-Archive '%CD%\Minecraft\temp\prism.zip' -DestinationPath '%CD%\Minecraft' -Force"
powershell "Expand-Archive '%CD%\Minecraft\temp\java.zip' -DestinationPath '%CD%\Minecraft' -Force"
echo Setting up...
powershell "Invoke-webrequest -URI 'https://projects.xrosecky.cz/prismaccounts' -OutFile '%CD%\Minecraft\accounts.json'"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://raw.githubusercontent.com/roseckyj/PortableMC/main/data/prismlauncher.cfg' '%CD%\Minecraft\prismlauncher.cfg'"
mkdir "%CD%\Minecraft\instances\%version%\.minecraft"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://raw.githubusercontent.com/roseckyj/PortableMC/main/data/%version%/instance.cfg' '%CD%\Minecraft\instances\%version%\instance.cfg'"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://raw.githubusercontent.com/roseckyj/PortableMC/main/data/%version%/mmc-pack.json' '%CD%\Minecraft\instances\%version%\mmc-pack.json'"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://raw.githubusercontent.com/roseckyj/PortableMC/main/data/servers.dat' '%CD%\Minecraft\instances\%version%\.minecraft\servers.dat'"
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://raw.githubusercontent.com/roseckyj/PortableMC/main/data/options.txt' '%CD%\Minecraft\instances\%version%\.minecraft\options.txt'"
goto launch
 
:end