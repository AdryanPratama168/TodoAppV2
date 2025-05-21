# Aplikasi Flutter & NestJS

## Tentang Aplikasi
Aplikasi ini terdiri dari dua komponen utama:
- **Aplikasi Mobile** yang dibangun menggunakan Flutter
- **Backend API** yang dibangun menggunakan NestJS

## Syarat
Sebelum memulai, pastikan Anda telah menginstal:

- [Flutter](https://flutter.dev/docs/get-started/install) 
- [Dart](https://dart.dev/get-dart) 
- [Node.js](https://nodejs.org/) 
- [npm](https://www.npmjs.com/) atau [yarn](https://yarnpkg.com/)
- [Git](https://git-scm.com/)
- [postgreSQL](https://www.postgresql.org/download/)

## Struktur Proyek
```
TodoAppV2/
├── frontend-flutter/        # Aplikasi mobile Flutter
└── backen-nestjs/           # API backend NestJS
```

## Memulai

### Setup Backend (NestJS)

1. Buka terminal dan masuk ke direktori backend:
   ```bash
   cd backend
   ```

2. Instal semua dependensi:
   ```bash
   npm install
   ```
   atau jika menggunakan yarn:
   ```bash
   yarn install
   ```

3. Salin file `.env.example` menjadi `.env` dan sesuaikan pengaturan:
   ```bash
   cp .env.example .env
   ```

4. Edit file `.env` sesuai dengan konfigurasi database dan pengaturan lainnya.


5. Jalankan server NestJS:
   ```bash
   npm run start:dev
   ```
   
6. API backend akan berjalan di `http://localhost:3000`

### Setup Mobile (Flutter)

1. Masuk ke direktori mobile:
   ```bash
   cd frontend-flutter
   ```

2. Instal dependensi Flutter:
   ```bash
   flutter pub get
   ```

3. Pastikan file konfigurasi (seperti `lib/config/api_config.dart`) telah diatur dengan URL API yang benar. Jika belum ada, buat file ini dan tambahkan:
   ```dart
   class ApiConfig {
     static const String baseUrl = 'http://10.0.2.2:3000'; // untuk emulator Android
     // atau 'http://localhost:3000' untuk iOS simulator
   }
   ```

4. Jalankan aplikasi Flutter:
   ```bash
   flutter run
   ```

## Fitur Utama TodoApp

- Melihat semua todo
- Menambahkan todo baru
- Mengedit todo
- Menghapus todo
- Autentikasi pengguna

## 📝 Catatan Tambahan
- Database harus di buat terlebih dahulu di postgreSQL dengan nama todoapp
- ubah nama file .env.example menjadi .env lalu isilah sesuai dengan format yang tertera
- Backend akan otomatis menyambung ke database PostgreSQL berdasarkan konfigurasi .env
- Table akan otomatis dibuat saat backend nya di run jadi tidak perlu membuat table lagi
- Jika aplikasi mobile tidak bisa terhubung ke backend, periksa kembali konfigurasi URL API dan pastikan emulator/simulator dapat mengakses server backend
