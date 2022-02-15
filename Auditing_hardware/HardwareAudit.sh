#!/bin/bash 

###################################################################
#Script Name	:                                                                                        
#Description:script to audit the following hardware  spec                                                                             
#Args : NA        	                                                                                       #Author       	:Shivam Mishra                                            
#Email         	:shivamm691@gmail.com  
#lastUbate: 15-02-2022                                         
###################################################################

echo --------------------------------Server -uptime------------------------ | tee -a info.txt 
uptime -p        | tee -a info.txt 


echo ----------------------------last-reboot---------------------- | tee -a info.txt
last reboot     | tee -a info.txt

echo ----------------------------Server Local Time Zone------------- | tee -a info.txt
 
timedatectl    | tee -a info.txt



echo ---------Last 10 installed packges with dates-------------------- | tee -a info.txt
rpm -qa --qf '%{INSTALLTIME} (%{INSTALLTIME:date}): %{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n' | sort -n | tail -10 | tee -a info.txt


echo ----------------------------OS version------------ | tee -a info.txt
hostnamectl    | tee -a info.txt





echo -------------------------Kernel version-------------------- | tee -a info.txt
 
hostnamectl | grep Kernel   | tee -a info.txt




echo -------------------------CPU-Virtual-------------------- | tee -a info.txt
 
lscpu | grep core    | tee -a info.txt
echo ------------------CPU - Clock speed----------------- | tee -a info.txt
 
lscpu | grep MHz    | tee -a info.txt


echo ---------------------------CPU - Architecture ----------------- | tee -a info.txt
 
lscpu | grep Architecture    | tee -a info.txt






echo -----------------------------Disk - Mounted/Unmounted ------------- | tee -a info.txt
 
df -h    | tee -a info.txt


echo ---------------------------------PrivateIP-------- | tee -a info.txt
 
hostname -I | awk '{print $1}'    | tee -a info.txt


echo -----------------------------------Public IP----------- | tee -a info.txt

curl ipinfo.io/ip | tee -a info.txt

echo ------------------------Networking-bandwith----------- | tee -a info.txt
ifstat | tee -a info.txt

echo ----------------------OS Firewall--Allowed Ports & Protocols----------- | tee -a info.txt
sudo systemctl status firewalld

sudo firewall-cmd --list-all
echo ----------------Network Firewall -Allowed Ports & Protocols----------- | tee -a info.txt
sudo ss -tulpn  | tee -a info.txt

sudo netstat -tulpn | grep LISTEN | tee -a info.txt

echo -----------------------------cpuuse - Utilization------------- | tee -a info.txt
cpuuse=$(cat /proc/loadavg | awk '{print $3}'|cut -f 1 -d ".")
if [ "$cpuuse" -ge 60 ]; then
echo "Server CPU usage is in over 60 "

else
echo "Server CPU usage is in under 60"
fi 


echo -----------------------------mem- Utilization------------- | tee -a info.txt

mem=$(free -t | awk 'NR == 2 {printf("%.2f%"), $3/$2*100}'|cut -f 1 -d ".")
echo $mem
if [ "$mem" -ge 60 ]; then
echo "Server mem usage is in over 60 "

else
echo "Server mem usage is in under 60"
fi 



echo -----------------------------Storage ------------- | tee -a info.txt
sudo df -h     | tee -a info.txt
disk=$(df -hl | awk '/^\/dev\/sd[ab]/ { sum+=$5 } END { print sum }')
if [ "$disk" -ge 60 ]; then
echo "Server disk usage is in over 60 "

else
echo "Server disk usage is in under 60"
fi 





echo ----------------------------- User Password Exipring------------- | tee -a info.txt
 
chage -l $(whoami) | tee -a info.txt
