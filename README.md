# Flutter Speed Code Challenge - Neo-Brutalism Hangman Game

**Nama Siswa / Peserta:** Attaridho Ananda Susilo  
**Topik Tugas:** Hangman Game (Nomor 3)  
**Batasan Kesalahan:** Maksimal 6 Kali Salah Tebak  
**Gaya Desain:** Neo-Brutalism  
**Waktu Praktikum:** 60 Menit (Production-Ready, Zero Error)

---

## 📌 Deskripsi Fitur Aplikasi

Aplikasi **Neo-Brutalism Hangman Game** ini dibangun menggunakan Flutter dengan prinsip *clean state management* dan arsitektur deklaratif berbasis single-file yang mandiri (`lib/main.dart`). Fitur-fitur utama meliputi:

1. **Bank Kata Tematik Coding & Teknologi:**
   - Menyediakan kumpulan istilah populer dunia rekayasa perangkat lunak (`FLUTTER`, `WIDGET`, `DART`, `ALGORITHM`, `INTERFACE`, `COMPILER`, `DATABASE`, `VARIABLE`, `FUNCTION`, `REACTIVE`).
   - Dilengkapi kategori spesifik dan petunjuk (*hint*) interaktif untuk mempermudah pemain tanpa mengurangi esensi tantangan.

2. **Tampilan Huruf Tersembunyi (Word Placeholders):**
   - Kotak representasi huruf dengan gaya Neo-Brutalism beranimasi responsif.
   - Posisi huruf langsung terbuka saat tebakan alfabet benar.
   - Terbuka otomatis dengan penanda merah saat pemain mengalami kekalahan (*Game Over*).

3. **Virtual Keyboard Interaktif (QWERTY):**
   - Tombol alfabet A-Z virtual di layar dengan feedback status instan:
     - **Hijau Mint (#2CEAA3):** Huruf tebakan benar.
     - **Merah/Pink Punch (#FF5376):** Huruf tebakan salah.
     - **Disabled & Flat Shadow:** Mencegah pemain mengklik huruf yang sama berulang kali.

4. **Visualisasi Karakter Hangman Interaktif (`CustomPainter`):**
   - Tiang gantungan digambar secara proporsional dengan garis tebal khas kartun/komik.
   - Karakter dieksekusi bertahap sesuai akumulasi kesalahan tebakan:
     - **0 Kesalahan:** Tiang gantungan lengkap (dasar, tiang tegak, balok atas, penyangga sudut, tali).
     - **1 Kesalahan:** Kepala berwajah ekspresif.
     - **2 Kesalahan:** Tubuh / batang badan (*torso*).
     - **3 Kesalahan:** Tangan kiri.
     - **4 Kesalahan:** Tangan kanan.
     - **5 Kesalahan:** Kaki kiri (indikator nyawa kritis).
     - **6 Kesalahan:** Kaki kanan (Kalah / *Game Over* - ekspresi mata X dan raut muka sedih).
     - **Status Menang:** Karakter berubah ekspresi menjadi wajah tersenyum bahagia dengan warna hijau mint.

5. **Sistem Status & Dialog Game Over:**
   - **Dialog Kemenangan (*Mission Accomplished*):** Muncul saat seluruh huruf berhasil dipecahkan, menampilkan perolehan skor (*PTS*) dan *Win Streak*.
   - **Dialog Kekalahan (*Game Over*):** Muncul ketika batas 6 kesalahan tercapai, mengungkap kata asli yang belum berhasil ditebak.

6. **Kontrol Game Lengkap:**
   - Tombol **"🔄 RESET / NEW GAME"** untuk mengacak kata baru secara dinamis.
   - Tombol **"Reset Total"** untuk mereset skor, streak, dan kata ke kondisi awal.

---

## 🎨 Penjelasan Implementasi Gaya Neo-Brutalism

Desain aplikasi mengadopsi estetika **Neo-Brutalism** modern dengan karakteristik visual yang khas:

- **Border Tebal Hitam Pekat (2.5px - 4px):**
  Setiap komponen (*Card, Button, Keyboard Key, Badge*) dibingkai garis hitam solid (`Colors.black`) yang tegas dan berani.
- **Hard Shadow Tanpa Blur (`blurRadius: 0`):**
  Efek bayangan menggunakan `BoxShadow` dengan pergeseran tajam (`Offset(3, 3)`, `Offset(4, 4)`, hingga `Offset(8, 8)`) tanpa degradasi blur, memberikan kedalaman retro pop-art 2D.
- **Palet Warna Kontras & Cerah (Pop-Art):**
  - Background Utama: *Vintage Warm Cream* (`#FFFDF0`)
  - Accent Kuning Tegas: *Yellow Punch* (`#FFDE59`)
  - Accent Pink Merah: *Pink Punch* (`#FF5376`)
  - Accent Hijau: *Mint Green* (`#2CEAA3`)
  - Accent Cyan: *Neon Cyan* (`#00F0FF`)
  - Accent Ungu: *Pastel Lavender* (`#F3E8FF`)
- **Sudut Komponen Melengkung Tegas:**
  Menggunakan `BorderRadius` terukur (4px hingga 12px) untuk menjaga keseimbangan antara gaya brutal dan ergonomis antarmuka sentuh.
- **Tipografi Bold & Monospace:**
  Menggunakan `FontWeight.w800` dan `FontWeight.w900` dengan font `monospace` untuk memberikan nuansa retro terminal coding yang kuat.
- **Micro-Interaction Taktil:**
  Tombol memiliki animasi transisi translasi (*press down*) saat disentuh atau diklik untuk mensimulasikan tombol fisik.

---

## 🚀 Panduan Menjalankan Aplikasi

Aplikasi dibangun murni menggunakan Flutter SDK bawaan (Material & Dart core) tanpa dependensi eksternal yang rentan bermasalah, sehingga dijamin kompatibel di berbagai platform (Android, iOS, Web, Windows Desktop).

### 1. Prasyarat
- Pastikan Flutter SDK sudah terpasang (versi 3.x ke atas).
- Pastikan emulator, perangkat fisik, atau browser Chrome siap digunakan.

### 2. Langkah Eksekusi

```bash
# 1. Masuk ke direktori proyek
cd c:\Users\ATTAR\Documents\HANGING

# 2. Ambil dependensi proyek
flutter pub get

# 3. Validasi kode (Lolos tanpa error lint)
flutter analyze

# 4. Jalankan pengujian widget
flutter test

# 5. Jalankan aplikasi
flutter run
```

*Tips untuk menjalankan di Web:*
```bash
flutter run -d chrome
```

*Tips untuk menjalankan di Windows Desktop:*
```bash
flutter run -d windows
```

---

## 🌐 Panduan Push ke GitHub Repository (Public)

Jalankan perintah berikut pada terminal untuk mengunggah proyek ke GitHub:

```bash
# 1. Pastikan status git bersih
git status

# 2. Tambahkan URL repository GitHub Anda
git remote add origin https://github.com/<username-github-anda>/<nama-repo-anda>.git

# 3. Unggah branch main ke remote repository
git push -u origin main
```
