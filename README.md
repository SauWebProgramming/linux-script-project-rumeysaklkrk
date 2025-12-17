## ÖĞRENCİ BİLGİLERİ

- **Ad Soyad:** Rümeysa Kolukırık 
- **Öğrenci Numarası:** B231200006
- **Ders:** Bilişim Sistemleri Altyapı ve Teknolojileri 


# Linux Server Dashboard

Bu projede Linux sunucusunun temel sistem bilgileri (CPU, RAM, Disk ve aktif kullanıcı sayısı)  
**Bash script** kullanılarak otomatik olarak toplanmış ve **Nginx** üzerinden web sayfası olarak gösterilmiştir.

## Proje İçeriği

- `monitor.sh`  
  Sunucu bilgilerini toplayan ve HTML çıktısı üreten bash script.

- `index.html`  
  Script tarafından otomatik oluşturulan web arayüzü  
  (`/var/www/html/index.html`).

- `screenshot.png`  
  Dashboard’un tarayıcıda çalışır hâlinin ekran görüntüsü.

## Kullanılan Teknolojiler

- Linux (Ubuntu – WSL)
- Bash
- Nginx
- Cron

## Script Açıklaması

`monitor.sh` scripti aşağıdaki bilgileri toplar:

- Tarih ve saat
- CPU kullanımı
- RAM kullanımı
- Disk doluluk oranı
- Aktif kullanıcı sayısı

Bu bilgiler her çalıştırmada HTML formatında `/var/www/html/index.html` dosyasına yazılır.

## Otomasyon (Cron)

Script, **cron** kullanılarak her dakika otomatik çalışacak şekilde ayarlanmıştır.

Cron girdisi:

```bash
* * * * * /mnt/c/Users/Rümeysa/OneDrive/Belgeler/GitHub/linux-script-project-rumeysaklkrk/monitor.sh
