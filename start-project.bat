@echo off
echo Starting MyPortfolio Project with IIS Express...
echo.

echo Checking if IIS Express is available...
if not exist "C:\Program Files\IIS Express\iisexpress.exe" (
    echo ERROR: IIS Express not found!
    echo Please install IIS Express or Visual Studio.
    pause
    exit /b 1
)

echo IIS Express found. Starting project...
echo.
echo Project will be available at: https://localhost:44352
echo Press Ctrl+C to stop the server
echo.

cd /d "%~dp0"
"C:\Program Files\IIS Express\iisexpress.exe" /path:"%CD%" /port:44352 /systray:false

pause