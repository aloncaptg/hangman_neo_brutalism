# Panduan Naskah Rekaman Video Demo (DEMO_SCRIPT.md)

**Judul Proyek:** Flutter Speed Code Challenge - Hangman Game Neo-Brutalism  
**Nama Peserta:** Attaridho Ananda Susilo  
**Durasi Maksimal:** 5 Menit  
**Media:** Rekaman Layar (Screen Recording) + Suara Jelas

---

## 📋 Checklist Persiapan Sebelum Record
- [ ] Layar emulator / Chrome dibuka dengan resolusi jernih (rasio aspek smartphone atau desktop).
- [ ] Terminal terbuka dan menampilkan `flutter analyze` dengan status `No issues found!`.
- [ ] Mikrofon aktif dan volume suara terdengar jelas.
- [ ] Aplikasi Hangman sudah berjalan pada layar siap interaksi.

---

## ⏱️ Timeline & Naskah Narasi Video (Maksimal 5 Menit)

### 1. Menit 00:00 - 00:45 | Pembukaan & Penjelasan Konsep UI Neo-Brutalism
- **Visual:** Tampilkan layar utama aplikasi yang penuh dengan warna pop-art cerah.
- **Narasi:**
  > *"Halo semuanya, perkenalkan saya **Attaridho Ananda Susilo**. Pada kesempatan Speed Code Challenge kali ini, saya mengembangkan proyek aplikasi **Hangman Game** bertema teknologi dan pemrograman.*  
  > *Sesuai dengan instruksi praktikum, antarmuka aplikasi ini dirancang penuh menggunakan gaya **Neo-Brutalism**. Ciri khas yang kami terapkan antara lain garis border hitam tebal 3 hingga 4 pixel di setiap card dan tombol, efek bayangan tegas tanpa blur (*hard shadow Offset 4,4*), palet warna pop-art cerah seperti kuning cerah, pink punch, dan mint green, serta tipografi tebal bergaya monospace.*  
  > *Semua komponen dibangun secara mandiri menggunakan Flutter murni tanpa library eksternal berlebih."*

---

### 2. Menit 00:45 - 02:30 | Demonstrasi Interaksi Gameplay & CustomPainter Hangman
- **Visual:** Cursor mengarahkan ke komponen info bar, hint, dan mulai memilih huruf pada virtual keyboard.
- **Narasi:**
  > *"Mari kita lihat komponen permainan ini. Di bagian atas terdapat kategori kata dan petunjuk tematik coding. Terdapat juga bar kesalahan dengan batasan maksimal **6 kali salah tebak**.*  
  > *Sekarang saya akan mencoba menekan huruf pada virtual keyboard di bawah. Ketika saya menebak huruf yang **benar**, perhatikan slot huruf langsung terbuka dengan warna hijau mint dan tombol keyboard dinonaktifkan.*  
  > *Selanjutnya, saya akan sengaja mencoba menebak huruf yang **salah**. Ketika salah, tombol keyboard berubah warna menjadi pink merah dan dinonaktifkan, counter kesalahan bertambah, dan yang paling menarik adalah visualisasi karakter Hangman di tengah yang digambar secara bertahap menggunakan **CustomPainter**.*  
  > *Setiap kesalahan memunculkan bagian tubuh baru secara proporsional: mulai dari kepala di kesalahan ke-1, badan di kesalahan ke-2, tangan kiri dan kanan di kesalahan ke-3 dan 4, serta kaki di kesalahan ke-5 dan 6."*

---

### 3. Menit 02:30 - 03:45 | Demonstrasi Skenario Menang (Win) & Kalah (Lose)
- **Visual:**
  - Lanjutkan menebak hingga menang -> Muncul Dialog Kemenangan (*Mission Accomplished*).
  - Lakukan satu game lagi dan buat kesalahan 6 kali -> Muncul Dialog Kekalahan (*Game Over*).
- **Narasi:**
  > *"Pada skenario pertama ini, saya akan melengkapi sisa huruf yang benar. Begitu semua huruf tertebak, muncul dialog kemenangan **'MISSION ACCOMPLISHED'** dengan warna hijau mint Neo-Brutalism, memberikan bonus skor serta menambah streak kemenangan.*  
  > *Sekarang mari kita uji skenario kedua yaitu kondisi **Kekalahan (Game Over)**. Saya akan memilih huruf-huruf yang salah hingga mencapai batas maksimal 6 kesalahan.*  
  > *Bisa kita lihat, pada kesalahan ke-6, karakter hangman lengkap dengan ekspresi mata silang (X) yang dramatis, indikator nyawa habis, dan muncul dialog **'GAME OVER'**. Di sini, sistem secara otomatis mengungkap kata asli yang gagal ditebak agar pemain mengetahui jawabannya secara transparan."*

---

### 4. Menit 03:45 - 04:30 | Demonstrasi Fitur Reset / New Game & Penutup
- **Visual:** Menekan tombol "MAIN LAGI / NEXT WORD" pada dialog atau tombol "🔄 RESET / NEW GAME" di bawah. Tunjukkan bahwa state ter-reset bersih dan kata baru muncul.
- **Narasi:**
  > *"Untuk memulai ronde baru, kita cukup menekan tombol **'MAIN LAGI'** atau tombol **'RESET / NEW GAME'** di bagian bawah. State permainan langsung dibersihkan, huruf tersembunyi diacak kembali dari bank kata tematik coding, dan tiang hangman kembali kosong siap untuk permainan berikutnya.*  
  > *Seluruh kode telah divalidasi dan lolos 100% pada `flutter analyze` dan `flutter test` tanpa warning ataupun issue.*  
  > *Demikian demonstrasi proyek Hangman Game bergaya Neo-Brutalism oleh saya, **Attaridho Ananda Susilo**. Terima kasih banyak atas perhatiannya!"*

---

## 🎯 Tips Tambahan
- Usahakan tempo berbicara santai dan percaya diri.
- Sorot cursor mouse pada bagian CustomPainter saat menjelaskan anatomi tiang dan tubuh hangman.
