#!/bin/bash
#--------------------------------
#IPERF3 NETBIRD automatisiert
#@author Michelle Buchinger
#--------------------------------

# IP Target im NETBIRD-Tunnel 
ziel_ip="100.125.135.6"
ergebnis=~/ansible/ergebnisse/iperf3/netbird
# iperf3 Befehl, Port wird dynamisch aus Clientnummer berechnet: client-01 > Port 5201, client-02 >Port 5202,..
# NR#0 entfernt führende 0
befehl='NR=$(hostname | grep -o "[0-9]*"); NR=${NR#0}; PORT=$((5200 + NR)); iperf3 -c 100.125.135.6 -p $PORT -t 10'

# ------------------------------------------
# VORBEREITUNGEN: WireGuard aus, NetBird an
# ------------------------------------------
ansible clients -m shell -a "wg-quick down wg0 2>/dev/null" --forks 20
ansible clients -m shell -a "netbird up" --forks 20

#10 Sekunden Puffer bevor Automatisierung startet
sleep 10

# ------------------------------------------------------------------------------------------
# Szenario 1: 1 Client misst Durchsatz mit 5 Runs
# iperf3 sendet 10 Sekunden lang Daten zum Target
# ------------------------------------------------------------------------------------------
ansible client-01 -m shell -a "$befehl" > $ergebnis/S1_R1.txt
ansible client-01 -m shell -a "$befehl" > $ergebnis/S1_R2.txt
ansible client-01 -m shell -a "$befehl" > $ergebnis/S1_R3.txt
ansible client-01 -m shell -a "$befehl" > $ergebnis/S1_R4.txt
ansible client-01 -m shell -a "$befehl" > $ergebnis/S1_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 2: 3 Clients messen Durchsatz mit 5 Runs
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03 -m shell -a "$befehl" --forks 3 > $ergebnis/S2_R1.txt
ansible client-01,client-02,client-03 -m shell -a "$befehl" --forks 3 > $ergebnis/S2_R2.txt
ansible client-01,client-02,client-03 -m shell -a "$befehl" --forks 3 > $ergebnis/S2_R3.txt
ansible client-01,client-02,client-03 -m shell -a "$befehl" --forks 3 > $ergebnis/S2_R4.txt
ansible client-01,client-02,client-03 -m shell -a "$befehl" --forks 3 > $ergebnis/S2_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 3: 5 Clients messen Durchsatz mit 5 Runs
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "$befehl" --forks 5 > $ergebnis/S3_R1.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "$befehl" --forks 5 > $ergebnis/S3_R2.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "$befehl" --forks 5 > $ergebnis/S3_R3.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "$befehl" --forks 5 > $ergebnis/S3_R4.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "$befehl" --forks 5 > $ergebnis/S3_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 4: 10 Clients messen Durchsatz mit 5 Runs
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "$befehl" --forks 10 > $ergebnis/S4_R1.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "$befehl" --forks 10 > $ergebnis/S4_R2.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "$befehl" --forks 10 > $ergebnis/S4_R3.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "$befehl" --forks 10 > $ergebnis/S4_R4.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "$befehl" --forks 10 > $ergebnis/S4_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 5: 20 Clients messen Durchsatz mit 5 Runs
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "$befehl" --forks 20 > $ergebnis/S5_R1.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "$befehl" --forks 20 > $ergebnis/S5_R2.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "$befehl" --forks 20 > $ergebnis/S5_R3.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "$befehl" --forks 20 > $ergebnis/S5_R4.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "$befehl" --forks 20 > $ergebnis/S5_R5.txt