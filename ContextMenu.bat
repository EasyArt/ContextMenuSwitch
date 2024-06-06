chcp 1252
rem Raphael Jäger
@ECHO off
title ContextMenu Installer
cls

:start
ECHO.
cls
ECHO Context Menu by Raphael Jaeger
ECHO Installieren oder Deinstallieren?
ECHO.
ECHO 1. Installieren
ECHO 2. Deinstallieren
set choice=
set /p choice=Wähle 1 oder 2: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto install
if '%choice%'=='2' goto uninstall
ECHO "%choice%" gibt es nicht bitte wähle neu!
ECHO.
goto start

:install
cls
echo "Installing Context Menu Switch"
reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version" /v SubCommands /t REG_DWORD /d 0
reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version" /v Icon /t REG_SZ /d C:\Windows\System32\imageres.dll,11

reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version\shell\Raphi war hier :)"

reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version\shell\Windows10\command" /ve /d "C:\RaphaelJaeger\Win10.bat" /f
reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version\shell\Windows10" /v Icon /t REG_SZ /d C:\Windows\System32\imageres.dll,250

reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version\shell\Windows11\command" /ve /d "C:\RaphaelJaeger\Win11.bat" /f
reg.exe add "HKCR\Directory\Background\shell\Kontext Menü Version\shell\Windows11" /v Icon /t REG_SZ /d C:\Windows\System32\imageres.dll,249

if not exist "C:\RaphaelJaeger\" mkdir C:\RaphaelJaeger

(
    echo reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    echo taskkill /F /IM explorer.exe
    echo timeout /t 1
    echo start explorer
) >C:\RaphaelJaeger\Win10.bat

(
    echo reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
    echo taskkill /F /IM explorer.exe
    echo timeout /t 1
    echo start explorer
) >C:\RaphaelJaeger\Win11.bat
goto end


:uninstall
cls
if exist "C:\RaphaelJaeger\" rd /s /q "C:\RaphaelJaeger"
reg.exe delete "HKCR\Directory\Background\shell\Kontext Menü Version" /f
goto end

:end
echo Program Stop