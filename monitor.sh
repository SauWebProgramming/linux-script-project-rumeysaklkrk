#!/bin/bash

# Çıktı dosyası
OUT="/var/www/html/index.html"

# Tarih-saat
TARIH="$(date)"

# CPU kullanımı (%): user+system (yaklaşık)
CPU="$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')"

# RAM (MB): used / total
RAM="$(free -m | awk 'NR==2{print $3 " MB / " $2 " MB"}')"

# Disk: / (root) doluluk yüzdesi
DISK="$(df -h / | awk 'NR==2{print $5}')"

# Aktif kullanıcı sayısı
USERS="$(who | wc -l)"

# CPU rengi
CPU_INT="$(printf "%.0f" "$CPU" 2>/dev/null)"
if [ -z "$CPU_INT" ]; then CPU_INT=0; fi

if [ "$CPU_INT" -ge 80 ]; then
  CPU_CLASS="danger"
elif [ "$CPU_INT" -ge 50 ]; then
  CPU_CLASS="warn"
else
  CPU_CLASS="ok"
fi

# HTML yaz
cat > "$OUT" <<EOF
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sunucu Durum Paneli</title>
  <style>
    body{font-family:Arial, sans-serif; background:#f3f5f7; padding:40px;}
    .container{max-width:720px; margin:auto; background:#fff; border-radius:14px;
      box-shadow:0 10px 30px rgba(0,0,0,.08); overflow:hidden;}
    .header{padding:22px 24px; background:#111827; color:#fff;}
    .header h1{margin:0; font-size:22px;}
    .header p{margin:6px 0 0; opacity:.85; font-size:13px;}
    .grid{display:grid; grid-template-columns:1fr 1fr; gap:14px; padding:18px 18px 22px;}
    .card{border:1px solid #e5e7eb; border-radius:12px; padding:14px 14px 12px; background:#fff;}
    .label{font-size:12px; color:#6b7280; margin-bottom:6px;}
    .value{font-size:20px; font-weight:700; color:#111827;}
    .badge{display:inline-block; padding:4px 10px; border-radius:999px; font-size:12px; font-weight:700;}
    .ok{background:#dcfce7; color:#166534;}
    .warn{background:#ffedd5; color:#9a3412;}
    .danger{background:#fee2e2; color:#991b1b;}
    .footer{padding:0 18px 18px; color:#6b7280; font-size:12px;}
    @media (max-width:640px){ .grid{grid-template-columns:1fr;} body{padding:16px;} }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Sunucu Durum Paneli</h1>
      <p>Son güncelleme: <b>$TARIH</b></p>
    </div>

    <div class="grid">
      <div class="card">
        <div class="label">CPU Kullanımı</div>
        <div class="value">$CPU%</div>
        <div style="margin-top:10px;">
          <span class="badge $CPU_CLASS">$CPU_CLASS</span>
        </div>
      </div>

      <div class="card">
        <div class="label">RAM</div>
        <div class="value">$RAM</div>
      </div>

      <div class="card">
        <div class="label">Disk Doluluk (/)</div>
        <div class="value">$DISK</div>
      </div>

      <div class="card">
        <div class="label">Aktif Kullanıcı</div>
        <div class="value">$USERS</div>
      </div>
    </div>

    <div class="footer">
      Bu sayfa <code>monitor.sh</code> tarafından otomatik güncellenir (cron).
    </div>
  </div>
</body>
</html>
EOF
