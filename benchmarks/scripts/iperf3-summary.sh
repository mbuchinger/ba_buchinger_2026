#!/bin/bash
#-------------------------------
#IPERF3 Ergebnisse zusammenführen von NETBIRD und WIREGUARD
#@author Michelle Buchinger
#------------------------------

# Eingabeoptionen
ordner=$1
loesung=$2
ausgabe=~/ansible/ergebnisse/iperf3_ergebnisse.csv

cd $ordner

# Header nur schreiben wenn Datei noch nicht existiert, Prüfung -f
if [ ! -f $ausgabe ]; then
    echo "Datei existiert nicht - schreibe Header"
    echo "Loesung;Szenario;Clients;Run;Throughput_Mbps" > $ausgabe
else
    echo "Datei existiert bereits"
fi

# Fileaufbau: S1_R1.txt
for file in S*_R*.txt; do

    # cut -d (trennzeichen), -f1 (feld 1) = S1
    szenario=$(echo $file | cut -d'_' -f1)
    #cut -d (trennzeichen), -f2 (feld 2), tr -d (löschen) R.txt = R
    run=$(echo $file | cut -d'_' -f2 | tr -d 'R.txt')
    #echo "DEBUG: $szenario $run"
    if [ $szenario = "S1" ]; then clients=1; fi
    if [ $szenario = "S2" ]; then clients=3; fi
    if [ $szenario = "S3" ]; then clients=5; fi
    if [ $szenario = "S4" ]; then clients=10; fi
    if [ $szenario = "S5" ]; then clients=20; fi

    # Throughput aus iperf3 sender-Zeile holen
    # tr fasst Leerzeilen zu einem zusammen, LC_ALL=C setzt Spracheinstellung auf englisch/amerikanisch damit systemdarstellung 1024 und nicht 1000 mbits/sec, awk= Feldbasierte Verarbeitung, $7 = Senderwert, $8 = Einheitsposition
    # tr . auf , ersetzen
    for throughput in $(grep "sender" $file | tr -s ' ' | LC_ALL=C awk '{if ($8 == "Gbits/sec") print int($7*1000); else print $7}' | tr '.' ','); do
        echo "$loesung;$szenario;$clients;$run;$throughput" >> $ausgabe
    done

done