@echo off

set myfile="C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\webapps\SampleMavenTomcatApp.war"
set myfolder="C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\webapps\SampleMavenTomcatApp"

if exist %myfolder% rmdir /S /Q %myfolder%
if exist %myfile% del %myfile%

::start /MIN "" "C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\bin\startup.bat"
call C:\apache-tomcat-8.5.69-windows-x64\apache-tomcat-8.5.69\bin\startup.bat
exit
echo hii

pause
