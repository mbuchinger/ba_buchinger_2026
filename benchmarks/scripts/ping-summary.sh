#!/bin/bash
#-------------------------------
#PING Ergebnisse zusammenführen von NETBIRD und WIREGUARD
#@author Michelle Buchinger
#------------------------------

# Eingabeoptionen
ordner=$1
loesung=$2
cd $ordner

#Ergebnisse Ausgabe gesamt
ausgabe=~/ansible/ergebnisse/ping_ergebnisse.csv

# Header nur schreiben wenn Datei noch nicht existiert, Prüfung -f
if [ ! -f $ausgabe ]; then
    echo "Datei existiert nicht - schreibe Header"
    echo "Loesung;Szenario;Clients;Run;RTT_ms" > $ausgabe
else
    echo "Datei existiert bereits"
fi
# Fileaufbau: S1_R1.txt
for  file in S*_R*.txt; do
        # cut -d (trennzeichen), -f1 (feld 1) = S1
        szenario=$(echo $file | cut -d'_' -f1)
        # cut -d (trennzeichen), -f2 (feld 2), tr -d (löschen) R.txt = R
        run=$(echo $file | cut -d'_' -f2 | tr -d 'R.txt')
        #echo "DEBUG: $szenario $run"
        if [ $szenario = "S1" ]; then clients=1; fi
        if [ $szenario = "S2" ]; then clients=3; fi
        if [ $szenario = "S3" ]; then clients=5; fi
        if [ $szenario = "S4" ]; then clients=10; fi
        if [ $szenario = "S5" ]; then clients=20; fi

		# für jeden RTT-Wert im File notwendig
		for avg in $(grep "rtt min" $file | cut -d'/' -f5 | tr '.' ','); do
			# CSV Trennzeichen ; Ausgabe
			echo "$loesung;$szenario;$clients;$run;$avg" >> $ausgabe
		done
done