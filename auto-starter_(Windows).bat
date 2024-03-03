@echo off
setlocal

echo DyNET-Client
echo.

:python_install_check
python --version > nul 2>&1
if %errorlevel% equ 0 (
    goto python_installed
) else (
    goto python_not_installed
)

:python_not_installed
echo Python is not installed.
echo If Python is not installed, you cannot run the program.
choice /C YN /M "Would you like to install Python "
echo.
if errorlevel 2 (
    echo You must install Python to run the program.
    echo.
    goto end
) else (
    goto python_install
)

:python_installed
echo Python is installed
echo start DyNET-Client . . . 
python updater.py
python client_cli.py
goto force_end

:python_install
set "python_url=https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe"
set "python_installer=python-3.12.2-amd64.exe"

echo Start installing Python.
echo Downloading python installer . . . 
powershell -command "(New-Object Net.WebClient).DownloadFile('%python_url%', '%python_installer%')"
if %errorlevel% neq 0 (
    echo ! Python installer download failed.
    echo   Check your internet connection.
    goto python_install_check
)
echo Python installer download complete.

echo Installing Python . . . 
start /wait %python_installer% PrependPath=1 /norestart /passive
if %errorlevel% neq 0 (
    echo Failed to install Python. Please try again later.
    echo.
    del %python_installer%
    goto python_install_check
)
del %python_installer%
echo Python installation successful.
echo.
goto python_install_check

:force_end
endlocal
exit

:end
endlocal
echo Program ended.
pause
