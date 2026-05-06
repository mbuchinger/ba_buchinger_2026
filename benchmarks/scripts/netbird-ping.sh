#!/bin/bash
#-----------------------------
#PING NETBIRD automatisiert 
#@author Michelle Buchinger
#----------------------------

# IP Target im NetBird-Tunnel
ziel_ip="100.125.135.6"

# Ergebnisse Speicherort
#ERGEBNIS=~/ansible/ergebnisse/ping/netbird
ergebnis=~/ansible/ergebnisse/ping/netbird

# ------------------------------------------
# VORBEREITUNGEN: WireGuard aus, NetBird an
# ------------------------------------------
# Fehlermeldungen werden mit 2>/dev/null ignoriert
ansible clients -m shell -a "wg-quick down wg0 2>/dev/null" --forks 20
ansible clients -m shell -a "netbird up" --forks 20

#10 Sekunden Puffer bevor Automatisierung startet
sleep 10

# ------------------------------------------------------------------------------------------
# Szenario 1: 1 Client pingt das Target mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# Vor jedem Run: Warmup-Ping für ARP-Auflösung + 5 Sekunden Restabilisierungsphase
# ------------------------------------------------------------------------------------------
for i in 1 2 3 4 5 6 7 8 9 10; do
  ansible client-01 -m shell -a "ping -c 1 -W 1 $ziel_ip > /dev/null 2>&1" && sleep 5
  ansible client-01 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" > $ergebnis/S1_R${i}.txt
done

# ------------------------------------------------------------------------------------------
# Szenario 2: 3 Clients pingen das Target mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# Vor jedem Run: Warmup-Ping für ARP-Auflösung + 5 Sekunden Restabilisierungsphase
# ------------------------------------------------------------------------------------------
for i in 1 2 3 4 5 6 7 8 9 10; do
  ansible client-01,client-02,client-03 -m shell -a "ping -c 1 -W 1 $ziel_ip > /dev/null 2>&1" --forks 3 && sleep 5
  ansible client-01,client-02,client-03 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 3 > $ergebnis/S2_R${i}.txt
done

# ------------------------------------------------------------------------------------------
# Szenario 3: 5 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# Vor jedem Run: Warmup-Ping für ARP-Auflösung + 5 Sekunden Restabilisierungsphase
# ------------------------------------------------------------------------------------------
for i in 1 2 3 4 5 6 7 8 9 10; do
  ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1 -W 1 $ziel_ip > /dev/null 2>&1" --forks 5 && sleep 5
  ansible client-01,client-02,client-03,client-04,client-05 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 5 > $ergebnis/S3_R${i}.txt
done
 
# ------------------------------------------------------------------------------------------
# Szenario 4: 10 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# Vor jedem Run: Warmup-Ping für ARP-Auflösung + 5 Sekunden Restabilisierungsphase
# ------------------------------------------------------------------------------------------
for i in 1 2 3 4 5 6 7 8 9 10; do
  ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1 -W 1 $ziel_ip > /dev/null 2>&1" --forks 10 && sleep 5
  ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 10 > $ergebnis/S4_R${i}.txt
done

# ------------------------------------------------------------------------------------------
# Szenario 5: 20 Clients pingen das Tagets mit 5 Runs
# ping sendet 1000 Pakete und wartet in einem Internvall von 0,01 Sekunden zwischen Paketen
# Vor jedem Run: Warmup-Ping für ARP-Auflösung + 5 Sekunden Restabilisierungsphase
# ------------------------------------------------------------------------------------------
for i in 1 2 3 4 5 6 7 8 9 10; do
  ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1 -W 1 $ziel_ip > /dev/null 2>&1" --forks 20 && sleep 5
  ansible client-01,client-02,client-03,client-04,client-05,client-06,client-07,client-08,client-09,client-10,client-11,client-12,client-13,client-14,client-15,client-16,client-17,client-18,client-19,client-20 -m shell -a "ping -c 1000 -i 0.01 $ziel_ip" --forks 20 > $ergebnis/S5_R${i}.txt
done
 