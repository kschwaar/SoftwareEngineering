@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat

echo.
echo Starting AIR Debug Launcher...
echo.

adl "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error

:: Clear bin folder and copy over assets to be packaged.
for /D %%p IN ("bin\*.*") DO rmdir "%%p" /s /q
xcopy "Assets" "bin\Assets" /s /c /y /i /q
xcopy "Menu" "bin\Menu" /s /c /y /i /q
xcopy "Icons" "bin\icons" /s /c /y /i /q

goto end

:error
pause

:end
