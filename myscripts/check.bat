@echo off

ECHO %DATE% %TIME% Calling %0 with %*
set /a count=1
:start
SET "URL=http://localhost:8088/login/user-login/"

SET HTTP=
for /f %%a in ( 'curl --write-out "%%{http_code}" -o nul -m 10 -q -s "%URL%"' ) do set HTTP=%%a


::echo %HTTP%

if "%HTTP%" == "200" (
echo Successfully pulled root page with %HTTP% status code
    exit /b 0
) else (
	echo Attempt to curl endpoint returned HTTP Code %HTTP% Backing off and retrying
	timeout 5
	set /a count+=1
	if %count%==3 ( echo failed with %HTTP% error ) else ( goto start )
	::call C:\Users\mahim\OneDrive\Desktop\url.bat
    exit /b 1
)

   
pause
