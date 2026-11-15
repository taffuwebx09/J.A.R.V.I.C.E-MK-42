@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title J.A.R.V.I.C.E MK-42 - One-Time Setup

echo ======================================================
echo           J.A.R.V.I.C.E MK-42 - ONE-TIME SETUP
echo ======================================================
echo.

where py >nul 2>nul
if %errorlevel%==0 (
    py -3 -m venv .venv
) else (
    python -m venv .venv
)
if errorlevel 1 goto :error

".venv\Scripts\python.exe" -c "import sys; print('Python version:', sys.version.split()[0]); assert sys.version_info >= (3, 10), 'Python 3.10 or newer is required.'"
if errorlevel 1 goto :error

echo.
echo [1/3] Installing required packages...
".venv\Scripts\python.exe" -m pip install --disable-pip-version-check -r requirements.txt
if errorlevel 1 goto :error

echo.
echo [2/3] Checking the installation...
".venv\Scripts\python.exe" -c "import streamlit, openpyxl, rapidfuzz; print('All required packages are ready.')"
if errorlevel 1 goto :error

echo.
echo [3/3] Creating the J.A.R.V.I.C.E MK-42 desktop shortcut...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_shortcut.ps1"
if errorlevel 1 goto :error

echo.
echo ======================================================
echo SETUP COMPLETE!
echo.
echo A J.A.R.V.I.C.E MK-42 shortcut is now on your Desktop.
echo From now on, double-click that shortcut to open the app.
echo No terminal commands are needed for daily use.
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo SETUP FAILED. Read the error above and share a screenshot.
echo Do not delete the project folder or the data folder.
echo.
pause
exit /b 1
