@echo off
echo Checking if Docker is running...
docker info >nul 2>&1
if errorlevel 1 (
    echo Docker is not running. Starting Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    echo Waiting up to 10 seconds for Docker to start...

    set /a counter=0
    :waitloop
    timeout /t 2 >nul
    docker info >nul 2>&1
    if not errorlevel 1 goto docker_ready
    set /a counter+=1
    if %counter% GEQ 5 (
        echo Docker failed to start within 10 seconds.
        pause
        exit /b
    )
    goto waitloop
)

:docker_ready
echo Docker is running. Starting containers...
docker compose --profile cpu up -d
pause
