#!/bin/bash
echo "cpu usage"
top -l 1 | grep "CPU usage" | awk '{print "Used: " $3 " " $4 " | Idle: " $7 " " $8}'
sw_vers
uptime
sysctl -n vm.loadavg
who
ps -Arcwwwxo pid,comm,rss | sort -k 3 -nr | head -n 5
ps -Ac -o pid,comm,%cpu | sort -k 3 -nr | head -n 5
df -h / | awk 'NR==2 {print "Used: " $3 " (" $5 ") | Free: " $4}'
vm_stat | awk '
/Pages free/        {free=$3}
/Pages active/      {active=$3}
/Pages inactive/    {inactive=$3}
/Pages speculative/ {speculative=$3}
/Pages wired down/  {wired=$3}
END {
  page_size=4096
  used=(active + inactive + speculative + wired) * page_size / 1024 / 1024
  free=free * page_size / 1024 / 1024
  total=used + free
  printf "Used: %.1f MB (%.1f%%) | Free: %.1f MB (%.1f%%)\n", used, used/total*100, free, free/total*100
}'
top -l 1 | grep "CPU usage" | awk '{print "Used: " $3 " " $4 " | Idle: " $7 " " $8}'


