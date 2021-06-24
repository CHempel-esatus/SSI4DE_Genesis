#!/bin/bash

# preconditions:

# 1. please execute this script with sudo

#    or call each line with sudo

#

# 2. package iptables-persistent

#       sudo apt install iptables-persistent

#    during installation the existing iptable-rules are saved at

#      - /etc/iptables/rules.v4

#      - /etc/iptables/rules.v6

# 

# 3. Network Interface

#   find out the correct interface with ifconfig

#    export MY_INTERFACE= found interface

# create new chain

iptables -N LOG_CONN_REJECT

# log-prefix

iptables -I LOG_CONN_REJECT -j LOG --log-prefix "connlimit: "

# Append a rule that finally rejects connection

iptables -I LOG_CONN_REJECT -p tcp -j REJECT --reject-with tcp-reset

# setting the connection limits

iptables -A INPUT -p tcp -m tcp --dport 9702 --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 500 --connlimit-mask 0 --connlimit-saddr  -j LOG_CONN_REJECT

# add rule for the different nodes

# current_validators --writeJson | node_address_list

# spherity

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 54.93.174.90 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Bosch

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 20.52.38.11 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Bundesdruckerei

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 193.28.64.163 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Commerzbank

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 20.52.50.218 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Deutsche Bahn

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 81.200.196.255 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# esatus_AG

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 194.110.133.202 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# GS1 Germany

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 49.12.122.178 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# ING Diba AG

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 20.50.0.0/16 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# MainIncubator

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 35.207.81.15 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# regio iT

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 91.102.136.153 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Siemens => OK

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 3.120.0.165 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# T-Labs

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 185.27.183.119  --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# tubzecm

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 141.23.35.186 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# mgm

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 185.40.248.112 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# msg

iptables -I INPUT -i $MY_INTERFACE -p TCP -s 3.126.145.208 --sport 1024:65535 --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Drop all other connections on node port

#iptables -A INPUT -i $MY_INTERFACE -p TCP --dport 9701 -m state --state NEW,ESTABLISHED,RELATED -j DROP

iptables -A INPUT -i $MY_INTERFACE -p TCP --dport 9701 -m state -j DROP

# save iptable content

bash -c ”iptables-save > /etc/iptables/rules.v4” 

