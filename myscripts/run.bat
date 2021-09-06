@echo off

::start /MIN "" "C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\bin\shutdown.bat"
call C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\bin\shutdown.bat
exit

set myfile="C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\webapps\SampleMavenTomcatApp.war"
set myfolder="C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\webapps\SampleMavenTomcatApp"

if exist %myfolder% rmdir /S /Q %myfolder%

move %myfile% C:\backup_war
::if exist %myfile% del %myfile%

echo hii

pause
