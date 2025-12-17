#!/bin/bash

OUT="/var/www/html/index.html"

TARIH="$(date)"
CPU="$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')"
RAM="$(free -m | awk 'NR==2{print $3 " MB / " $2 " MB"}')"
DISK="$(df -h / | awk 'NR==2{print $5}')"
USERS="$(who | wc -l)"

CPU_INT="$(printf "%.0f" "$CPU" 2>/dev/null)"
[ -z "$CPU_INT" ] && CPU_INT=0

if [ "$CPU_INT" -ge 80 ]; then
  CPU_CLASS="danger"
elif [ "$CPU_INT" -ge 50 ]; then
  CPU_CLASS="warn"
else
  CPU_CLASS="ok"
fi

cat > "$OUT" <<HTML
<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="UTF-8">
<title>Sunucu Durum Paneli</title>
<style>
body {
  font-family: Arial, sans-serif;
  background: #f4f6f8;
}
.card {
  width: 360px;
  margin: 60px auto;
  background: white;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 10px 25px rgba(0,0,0,.1);
}
h1 {
  text-align: center;
}
.ok { color: green; }
.warn { color: orange; }
.danger { color: red; }
</style>
</head>
<body>
<div class="card">
<h1>Sunucu Durum Paneli</h1>
<p><b>Tarih:</b> $TARIH</p>
<p><b>CPU:</b> <span class="$CPU_CLASS">$CPU%</span></p>
<p><b>RAM:</b> $RAM</p>
<p><b>Disk:</b> $DISK</p>
<p><b>Aktif Kullanıcı:</b> $USERS</p>
</div>
</body>
</html>
HTML
