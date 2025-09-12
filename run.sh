#!/bin/bash
cd "$(dirname "$0")"

echo "Iniciando 5 Electrovalvula..."
for ((i=0; i<=4; i++)); do
    java -jar Electrovalula.jar "$i" &
done

echo "Esperando 5 segundos a las valvulas..."
sleep 5

echo "Starting Controlador..."
java -jar Controlador.jar &

echo "Esperando 5 segundos al controlador..."
sleep 5

echo "Iniciando sensores globales..."
java -jar SensorIluminacion.jar &
java -jar SensorLluvia.jar &
java -jar SensorTemperatura.jar &

echo "Iniciando 5 SensorHumedad..."
for ((i=0; i<=4; i++)); do
    java -jar SensorHumedad1.jar "$i" &
done

echo "Iniciando 5 Temporizador..."
for ((i=0; i<=4; i++)); do
    java -jar Temporizador.jar "$i" &
done

echo
echo "Listo"