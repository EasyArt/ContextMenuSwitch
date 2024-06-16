chcp 1252
rem Raphael Jäger
@ECHO off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  

title Win11DesignSwitch Installer
cls

:start
ECHO.
cls
ECHO Win11DesignSwitch by Raphael Jäger
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
if not exist "C:\RaphaelJaeger" mkdir "C:\RaphaelJaeger"
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/Win11DesignSwitch.reg > C:\RaphaelJaeger\Win11DesignSwitch.reg
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/EXWin10.reg > C:\RaphaelJaeger\EXWin10.reg
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/EXWin10.bat > C:\RaphaelJaeger\EXWin10.bat
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/EXWin11.bat > C:\RaphaelJaeger\EXWin11.bat
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/CMWin10.bat > C:\RaphaelJaeger\CMWin10.bat
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/CMWin11.bat > C:\RaphaelJaeger\CMWin11.bat
curl https://raw.githubusercontent.com/EasyArt/Win11DesignSwitch/main/uninstaller.bat > C:\RaphaelJaeger\uninstaller.bat
regedit.exe /s C:\RaphaelJaeger\Win11DesignSwitch.reg
goto end


:uninstall
cls
CALL C:\RaphaelJaeger\uninstaller.bat
reg.exe delete "HKCR\Directory\Background\shell\Win11DesignSwitch" /f
timeout /t 3
if exist "C:\RaphaelJaeger\" rd /s /q "C:\RaphaelJaeger"
goto end

:end
echo Program Stop
PAUSE
