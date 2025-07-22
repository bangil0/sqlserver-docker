@echo off
setlocal

:: ======================== KONFIGURASI ========================
set CONTAINER_NAME=sqlserver2022
set SA_PASSWORD=P@ssw0rd123  :: Ganti kalau mau
set DATA_PATH=D:\sqlserver-data
set IMAGE=mcr.microsoft.com/mssql/server:2022-latest
:: =============================================================

echo [1] Cek folder penyimpanan...
if not exist "%DATA_PATH%" (
    mkdir "%DATA_PATH%"
    echo Folder dibuat: %DATA_PATH%
)

echo [2] Hapus container lama (jika ada)...
docker rm -f %CONTAINER_NAME% >nul 2>&1

echo [3] Menjalankan container SQL Server di Docker...
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=%SA_PASSWORD%" ^
 -p 1433:1433 --name %CONTAINER_NAME% ^
 -v "%DATA_PATH%:/var/opt/mssql" ^
 -d %IMAGE%

echo -------------------------------------------------------
echo ✅ SQL Server Docker sedang berjalan di port 1433
echo 🔐 Username : SA
echo 🔑 Password : %SA_PASSWORD%
echo 📁 Data disimpan di : %DATA_PATH%
echo -------------------------------------------------------

pause
