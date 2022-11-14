# Laporan Praktikum 3

## Soal DHCP

> 1. Loid bersama Franky berencana membuat peta tersebut dengan kriteria WISE sebagai DNS Server, Westalis sebagai DHCP Server, Berlint sebagai Proxy Server,

> 2. Ostania sebagai DHCP Relay

![](/img/1.4.png)

![](/img/1.5.png)

![](/img/1.1.png)

![](/img/1.2.png)

![](/img/1.3.png)

> 3. Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.50 - [prefix IP].1.88 dan [prefix IP].1.120 - [prefix IP].1.155

![](/img/3.1.png)

> 4. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.10 - [prefix IP].3.30 dan [prefix IP].3.60 - [prefix IP].3.85

![](/img/4.1.png)

> 5. Client mendapatkan DNS dari WISE dan client dapat terhubung dengan internet melalui DNS tersebut. (5)

![](/img/5.1.png)

> 6. Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 5 menit sedangkan pada client yang melalui Switch3 selama 10 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 115 menit.

![](/img/6.1.png)

## Soal Proxy

> 1. Client hanya dapat mengakses internet diluar (selain) hari & jam kerja (senin-jumat 08.00 - 17.00) dan hari libur (dapat mengakses 24 jam penuh)

![](/img/B.1.1.png)

> 2. Adapun pada hari dan jam kerja sesuai nomor (1), client hanya dapat mengakses domain loid-work.com dan franky-work.com

![](/img/B.2.1.png)

> 3. Saat akses internet dibuka, client dilarang untuk mengakses web tanpa HTTPS. (Contoh web HTTP: http://example.com)  

HTTPS menggunakan port 443, oleh karena itu nomor ini dapat dilakukan dengan cara blokir akses web selain pada port 443  
Pada `/etc/squid/acl.conf`, tambahkan
```
acl SSL_ports port 443
```
Lalu di `/etc/squid/squid.conf`, tambahkan
```
http_access deny !SSL_ports
```
![](/img/B.3.1.png)
> 4. Agar menghemat penggunaan, akses internet dibatasi dengan kecepatan maksimum 128 Kbps pada setiap host (Kbps = kilobit per second; lakukan pengecekan pada tiap host, ketika 2 host akses internet pada saat bersamaan, keduanya mendapatkan speed maksimal yaitu 128 Kbps)
> 5. Setelah diterapkan, ternyata peraturan nomor (4) mengganggu produktifitas saat hari kerja, dengan demikian pembatasan kecepatan hanya diberlakukan untuk pengaksesan internet pada hari libur  

Definisikan hari yang mau dibatasi di acl.conf
```
acl NO_LIMIT_DAYS time MTWHF
```
Lalu menambahkan bari berikut untuk membatasi internet menjadi 128 kbps
```
delay_pools 1
delay_class 1 2
delay_access 1 allow all !NO_LIMIT_DAYS
delay_parameters 1 none 16000/16000
```
Koneksi internet pada hari senin di luar jam kerja  
![](/img/B.4.1.png)  
Koneksi internet pada hari sabtu  
![](/img/B.4.2.png)  
