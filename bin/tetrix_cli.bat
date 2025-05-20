@echo off
:: This file was created by tetrix_cli activation script.
:: Package: tetrix_cli
:: Executable: tetrix_cli
:: Script: tetrix_cli
set SNAPSHOT_PATH=%USERPROFILE%\.pub-cache\global_packages\tetrix_cli\bin\tetrix_cli.dart.snapshot
if exist "%SNAPSHOT_PATH%" (
  dart "%SNAPSHOT_PATH%" %*
  :: The VM exits with code 253 if the snapshot version is out-of-date.
  if %ERRORLEVEL% NEQ 253 (
    exit /b %ERRORLEVEL%
  )
  del "%SNAPSHOT_PATH%"
  dart pub global run tetrix_cli:tetrix_cli %*
) else (
  dart pub global run tetrix_cli:tetrix_cli %*
)