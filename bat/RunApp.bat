@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1

for /D %%p IN ("bin\*.*") DO rmdir "%%p" /s /q
xcopy "Assets" "bin\Assets" /s /c /y /i /q
xcopy "Menu" "bin\Menu" /s /c /y /i /q
xcopy "Icons" "bin\icons" /s /c /y /i /q

call bat\SetupSDK.bat
call bat\SetupApp.bat

echo.
echo Starting AIR Debug Launcher...
echo.

adl "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error
goto end

:error
pause

:end
