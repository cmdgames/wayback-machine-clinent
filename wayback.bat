@echo off
:z
if not exist wayback md wayback
echo s=save
echo v=view
echo e=exit
echo d=download
set /p a="option:"
if "%a%"=="s" goto a
if "%a%"=="v" goto e
if "%a%"=="d" goto f
if "%a%"=="e" goto g
:a
set b=sd
set c=1
set /p real="url:"
set a=%real:&= %
if %a:~5,1%==: set k=%a:~8%
if %a:~4,1%==: set k=%a:~7%
if %a:~3,1%==: set k=%a:~6%
call :g %k:?= %
call :g %j:/= %
ping -a -n 1 -i 100 -w 1000 %j%
if %errorlevel%==1 call :b
curl %real%>output.txt
set /p b=<output.txt
if "%b:~0,2%"=="sd" call :d
:c
curl https://web.archive.org/save/%real%>responce.txt
findstr /M /C:"This URL has been already captured 10 times today." responce.txt>output.txt
set /p b=<output.txt
if "%b%"=="%cd%\responce.txt" echo page already archived
if "%b%"=="responce.txt" echo page already archived
findstr /M /C:"Cannot resolve host %real%" responce.txt>output.txt
set b=sd
set /p b=<output.txt
if "%b%"=="%cd%\responce.txt" echo page no longer exists
if "%b%"=="responce.txt" echo page no longer exists
findstr /M /C:" URL syntax is not valid.</p>" responce.txt>output.txt
set b=sd
set /p b=<output.txt
if "%b%"=="%cd%\responce.txt" echo URL syntax is not valid
if "%b%"=="responce.txt" echo URL syntax is not valid
goto :z
:b
echo page cant be pinged contine arciving y/n
set /p c=""
if %c%==n goto :a
goto :c
:d
title %a%
echo page is blank contine arciving y/n
set /p c=""
if %c%==n goto :a
exit /b
:e
set /p a="url:"
fc cmd.exe cmd.exe
ping -a -n 1 -i 100 -w 1000 web.archive.org
set er=%errorlevel%
title %er% %errorlevel%
if %er%==0 start "" https://web.archive.org/%a%
if %er%==1 wayback\%a%.html
goto :z
:f
set /p a="url:"
del wayback\%a%.html
curl https://web.archive.org/%a%>wayback\%a%.txt
ren wayback\%a%.txt %a%.html
goto :z
:g
set j=%1
:h