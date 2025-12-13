#!/bin/bash

# Tarih ve saat
TARIH=$(date)

# CPU kullanımı
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# RAM durumu
RAM=$(free -m | awk 'NR==2{print $3 " / " $2 " MB"}')

# Disk durumu
DISK=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')

# Aktif kullanıcı sayısı
USERS=$(who | wc -l)

# HTML dosyasının yolu
OUT="/var/www/html/index.html"

echo "<html><body>" > $OUT
echo "<h1>Sunucu Durum Paneli</h1>" >> $OUT
echo "<p><b>Tarih:</b> $TARIH</p>" >> $OUT
echo "<p><b>CPU Kullanımı:</b> $CPU %</p>" >> $OUT
echo "<p><b>RAM Kullanımı:</b> $RAM</p>" >> $OUT
echo "<p><b>Disk Kullanımı:</b> $DISK</p>" >> $OUT
echo "<p><b>Aktif Kullanıcı Sayısı:</b> $USERS</p>" >> $OUT
echo "</body></html>" >> $OUT
