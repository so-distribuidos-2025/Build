@echo off

cd /d "%~dp0"

echo Iniciando Servidor Mutex...
start "Servidor Mutex" java -jar ServidorExclusionMutua.jar

echo Esperando 3 segundos al Mutex...
timeout /t 3 /nobreak > nul

echo Iniciando Sistema Fertirrigacion...
start "Sistema Fertirrigacion" java -jar SistemaFertirrigacion.jar

echo Iniciando 7 Electrovalvula...
for /L %%i in (0, 1, 6) do (
    start "Electrovalvula %%i" java -jar Electrovalula.jar %%i
)

echo Esperando 5 segundos a las valvulas...
timeout /t 5 /nobreak > nul

echo Starting Controlador...
start "Controlador" java -jar Controlador.jar

echo Esperando 5 segundos al controlador...
timeout /t 5 /nobreak > nul

echo Iniciando sensores globales...
start "SensorIluminacion" java -jar SensorIluminacion.jar
start "SensorLluvia" java -jar SensorLluvia.jar
start "SensorTemperatura" java -jar SensorTemperatura.jar

echo Iniciando 5 SensorHumedad...
for /L %%i in (0, 1, 4) do (
    start "SensorHumedad %%i" java -jar SensorHumedad1.jar %%i
)

echo Iniciando 5 Temporizador...
for /L %%i in (0, 1, 4) do (
    start "Temporizador %%i" java -jar Temporizador.jar %%i
)

echo.
echo Listo