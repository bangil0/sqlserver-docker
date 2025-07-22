@echo off
setlocal

:: ========== Konfigurasi ==========
set CONTAINER_NAME=sqlserver2022
set SA_PASSWORD=P@ssw0rd123
set DATA_PATH=D:\sqlserver-data
set IMAGE=mcr.microsoft.com/mssql/server:2022-latest
:: =================================

echo --------------------------------------
echo [1] Mengecek folder data...
if not exist "%DATA_PATH%" (
    mkdir "%DATA_PATH%"
    echo Folder "%DATA_PATH%" dibuat.
) else (
    echo Folder "%DATA_PATH%" sudah ada.
)

echo --------------------------------------
echo [2] Mengecek container lama...

docker ps -a --format "{{.Names}}" | findstr /I %CONTAINER_NAME% >nul
if %errorlevel%==0 (
    echo Container '%CONTAINER_NAME%' sudah ada.
    echo Menghapus container lama...
    docker rm -f %CONTAINER_NAME%
    echo Container lama dihapus.
) else (
    echo Tidak ada container lama dengan nama '%CONTAINER_NAME%'.
)

echo --------------------------------------
echo [3] Menjalankan SQL Server di Docker...
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=%SA_PASSWORD%" ^
 -p 1433:1433 --name %CONTAINER_NAME% ^
 -v "%DATA_PATH%:/var/opt/mssql" ^
 -d %IMAGE%

if %errorlevel%==0 (
    echo SQL Server berhasil dijalankan dengan nama container: %CONTAINER_NAME%
) else (
    echo GAGAL menjalankan container. Periksa error di atas.
    pause
    exit /b
)

echo --------------------------------------
echo [4] Status container:
docker ps --filter "name=%CONTAIN
