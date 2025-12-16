#!/bin/bash

TARIH=$(date)

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

RAM=$(free -m | awk 'NR==2{print $3 " / " $2 " MB"}')

DISK=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')

USERS=$(who | wc -l)

OUT="/var/www/html/index.html"

echo "<html><head><meta charset='utf-8'></head><body>" > "$OUT"
echo "<h1>Sunucu Durum Paneli</h1>" >> "$OUT"
echo "<p><b>Tarih:</b> $TARIH</p>" >> "$OUT"
echo "<p><b>CPU Kullanımı:</b> $CPU%</p>" >> "$OUT"
echo "<p><b>RAM:</b> $RAM</p>" >> "$OUT"
echo "<p><b>Disk Doluluk:</b> $DISK</p>" >> "$OUT"
echo "<p><b>Aktif Kullanıcı:</b> $USERS</p>" >> "$OUT"
echo "</body></html>" >> "$OUT"

