#!bin/bash
ARCH=$(uname -a)
PCPU=$(grep physical.id /proc/cpuinfo | wc –l)
VCPU=$(grep processor /proc/cpuinfo | wc –l)
MEM1=$(free -m | grep "Mem:" | awk '{print $3}')
MEM2=$(free -m | grep "Mem:" | awk '{print $2}')
MEM3=$(free -m | grep "Mem:" | awk '{printf("%.2f"), $3/$2*100}')
DISK1=$(df -m --total | grep "total" | awk '{print $3}')
DISK2=$(df -h --total | grep "total" | awk '{printf ("%.0f"), $2}')
DISK3=$(df -h --total | grep "total" | awk '{print $5}')
CPUL=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')
LB=$(who -b | awk '$1 == “SYSTEM” {print $3 " " $4 }')
LVMU=$(if lsblk | grep -q "lvm";then echo "yes"; else echo "no"; fi)
CTCP=$(ss –s | awk ‘/TCP:/{print $2}’)
ULOG=$(users | wc -w)
IP=$(hostname -I | awk '{print $1}')
MAC=$(ip a | grep “ether” | awk ‘{print $2}’)
SUDO=$(grep –c ‘COMMAND’ /var/log/sudo/sudo.log)

wall "
        #Architecture: $ARCH
        #CPU physical: $PCPU
        #vCPU: $VCPU
        #Memory Usage: $MEM1/${MEM2}MB ($MEM3%)
        #Disk Usage: $DISK1/${DISK2}GB ($DISK3)
        #CPU load: $CPUL
        #Last boot: $LB
        #LVM use: $LVMU
        #Connections TCP: $CTCP ESTABLISHED
        #User log: $ULOG
        #Network: IP $IP ($MAC)
        #Sudo: $SUDO cmd
"
