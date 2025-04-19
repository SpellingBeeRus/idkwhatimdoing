@echo off
setlocal enabledelayedexpansion

echo ========================================
echo A.C.A.S Auto-Updater
echo ========================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Git is not installed or not in your PATH.
    echo Please install Git from https://git-scm.com/download/win
    pause
    exit /b 1
)

:: Create a temporary directory for cloning
set "TEMP_DIR=%TEMP%\acas_temp"
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

:: Clone the repository
echo Cloning the latest version of A.C.A.S...
git clone https://github.com/Psyyke/A.C.A.S.git "%TEMP_DIR%"
if %ERRORLEVEL% neq 0 (
    echo Failed to clone repository.
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)

:: Remove git-related files from the cloned repository
if exist "%TEMP_DIR%\.git" rmdir /s /q "%TEMP_DIR%\.git"

:: Current directory
set "CURRENT_DIR=%~dp0"

:: Ask for confirmation
echo.
echo Warning: This will delete all current A.C.A.S files in this directory.
echo Current directory: %CURRENT_DIR%
echo.
set /p CONFIRM="Are you sure you want to continue? (Y/N): "
if /i "%CONFIRM%" neq "Y" (
    echo Update cancelled.
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 0
)

:: Delete old files and directories (preserving the batch file itself)
echo.
echo Deleting old files...
for %%F in (*.js *.md *.html *.ico LICENSE .nojekyll) do (
    if "%%~nxF" neq "update_acas.bat" (
        if exist "%%F" del /q "%%F"
    )
)

:: Delete old directories
for /d %%D in (*) do (
    if "%%D" neq ".git" (
        rmdir /s /q "%%D"
    )
)

:: Copy new files and directories
echo Copying new files...
xcopy /e /y "%TEMP_DIR%\*" "%CURRENT_DIR%"

:: Clean up
rmdir /s /q "%TEMP_DIR%"

echo.
echo ========================================
echo A.C.A.S has been successfully updated!
echo ========================================
echo.
pause 