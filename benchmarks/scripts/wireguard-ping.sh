#!/bin/bash
#-------------------------------
#PING WIREGUARD automatisiert
#@author Michelle Buchinger
#------------------------------

# IP Target im WireGuard-Tunnel
ziel_ip="10.0.0.200"

# Ergebnisse Speicherort
ergebnis=~/ansible/ergebnisse/ping/wireguard

# ------------------------------------------
# VORBEREITUNGEN: NetBird aus, WireGuard an
# ------------------------------------------
# Fehlermeldungen werden mit 2>/dev/null ignoriert
ansible clients -m shell -a "netbird down 2>/dev/null" --forks 20
ansible clients -m shell -a "wg-quick up wg0" --forks 20

#10 Sekunden Puffer bevor Automatisierung startet
sleep 10

# ------------------------------------------------------------------------------------------
# Szenario 1: 1 Client pingt das Target mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# ------------------------------------------------------------------------------------------
ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R1.txt
ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R2.txt
ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R3.txt
ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R4.txt
ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 2: 3 Clients pingen das Target mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R1.txt
ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R2.txt
ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R3.txt
ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R4.txt
ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 3: 5 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R1.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R2.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R3.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R4.txt
ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 4: 10 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R1.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R2.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R3.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R4.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R5.txt

# ------------------------------------------------------------------------------------------
# Szenario 5: 20 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# ------------------------------------------------------------------------------------------
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R1.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R2.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R3.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R4.txt
ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R5.txt
