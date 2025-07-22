@echo off
setlocal

:: Ganti password ini sesuai kebutuhan (WAJIB kuat: huruf besar, kecil, angka, simbol, min 8 karakter)
set SA_PASSWORD=P@ssw0rd123

:: Ganti lokasi penyimpanan di drive D
set DATA_PATH=D:\sqlserver-data

:: Nama container
set CONTAINER_NAME=sqlserver2022

:: Buat folder jika belum ada
if not exist "%DATA_PATH%" (
    mkdir "%DATA_PATH%"
    echo Folder "%DATA_PATH%" dibuat.
)

:: Jalankan SQL Server container
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=%SA_PASSWORD%" ^
 -p 1433:1433 --name %CONTAINER_NAME% ^
 -v "%DATA_PATH%:/var/opt/mssql" ^
 -d mcr.microsoft.com/mssql/server:2022-latest

echo SQL Server container '%CONTAINER_NAME%' sedang berjalan...
pause
