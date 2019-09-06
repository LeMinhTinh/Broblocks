ECHO OFF
CLS
setlocal
REM for %%I in (.) do set "project_name=%%~nxI"
set "project_name=EOX6021_ClickDummy"
set "build_directory=release"
set "qt_env=C:\Qt\5.12.2\mingw73_64\bin\qtenv2.bat"
ECHO Deploy %project_name%
ECHO build_directory: %build_directory%
ECHO qt_env: %qt_env%

:MENU
ECHO.
ECHO 1 - Deploy for Siemens
ECHO * - EXIT
ECHO.
set "M="
SET /P M=Type 1, 2, or any other key then press ENTER:
set "deployment_mode="
IF %M%==1 set "deployment_mode=siemens"
IF [%deployment_mode%]==[] GOTO EOF

ECHO ON
set "deployment_directory=%~dp0\%deployment_mode%\%project_name%"
CD %~dp0
robocopy %build_directory%\ %deployment_directory% %project_name%.exe /COPY:DAT
robocopy resources\%deployment_mode% %deployment_directory%\resources\%deployment_mode% /COPY:DAT /E
echo mode=%deployment_mode% > %deployment_directory%\resources\mode.ini
call %qt_env%
windeployqt.exe --qmldir %~dp0\view --compiler-runtime --release %deployment_directory%
ECHO OFF
GOTO MENU