# 🐉 Kompilator Kernel Kali NetHunter untuk Samsung Galaxy S10+ (beyond2lte)

[![Lisensi: MIT](https://img.shields.io/badge/Lisensi-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Perangkat: Galaxy S10+](https://img.shields.io/badge/Perangkat-Samsung%20Galaxy%20S10%2B%20(SM--G975F)-blue.svg)](#)
[![SoC: Exynos 9820](https://img.shields.io/badge/SoC-Samsung%20Exynos%209820-9cf.svg)](#)
[![Kernel: Linux 4.14](https://img.shields.io/badge/Kernel-Linux%204.14-green.svg)](#)
[![Platform: Kali NetHunter](https://img.shields.io/badge/Platform-Kali%20NetHunter-black.svg?logo=kali-linux&logoColor=white)](#)
[![Developer: Muhammad Fikri](https://img.shields.io/badge/Developer-Muhammad%20Fikri-blue.svg)](#)

Repositori otomasi kompilasi kernel kustom, alur kerja CI/CD GitHub Actions, dan skrip pembuatan kernel **Kali NetHunter Linux 4.14** untuk perangkat **Samsung Galaxy S10+ (beyond2lte / SM-G975F)** berbasis source tree LineageOS resmi (`v0lk3n & yesimxev`).

---

## 📑 Spesifikasi Teknis & Informasi Upstream

| Parameter | Nilai Spesifikasi |
| :--- | :--- |
| **Nama Perangkat** | Samsung Galaxy S10+ |
| **Codename / Kernel ID** | `beyond2lte` / `beyond2lte-lossixteen` |
| **Prosesor** | Samsung Exynos 9820 Octa-core (`aarch64`) |
| **Versi Kernel** | Linux 4.14.x LTS |
| **Target ROM** | LineageOS 21 / 22.x / 23.x (AOSP Android 14–16 Base) |
| **Author Kernel** | `v0lk3n` & `yesimxev` |
| **Repositori Upstream** | [v0lk3n/nethunter_kernel_samsung_exynos9820](https://github.com/v0lk3n/nethunter_kernel_samsung_exynos9820) |

---

## ⚡ Fitur Keamanan & Modul yang Diaktifkan

- 📡 **Injeksi Paket Nirkabel & Monitor Mode:**
 - `Nexmon`: Monitor mode dan injeksi paket langsung dari chip Wi-Fi internal Broadcom.
 - Patch sub-sistem nirkabel `mac80211` & `cfg80211`.
- 🔌 **Driver Adaptor Wi-Fi Eksternal USB:**
 - `ATH9K_HTC` (Atheros AR9271)
 - `RTL8188EUS`
 - `RTL8812AU` / `RTL88XXAU` / `RTL88X2BU` (Realtek 802.11ac dual-band)
- ⌨️ **USB Arsenal & Serangan BadUSB (HID):**
 - `HID-4`: Emulasi keyboard dan mouse USB Gadget untuk pengujian keystroke injection.
 - Emulasi USB Mass Storage CD-ROM (dukungan DriveDroid).
- 📶 **Bluetooth & Jaringan:**
 - Injeksi Bluetooth `BT_RFCOMM` dan `INTERNAL_BT`.
 - Sub-sistem jaringan `CAN Bus`.
 - Sistem berkas `NFS` dan routing VPN `TUN/TAP`.
- 🛡️ **Bypass Proteksi Keamanan Samsung:**
 - Menonaktifkan integritas KNOX, TIMA, Defex, dan RKP untuk akses root penuh dan chroot Kali NetHunter.

---

## 🚀 Panduan Kompilasi Kernel

### Metode 1: Kompilasi Lokal Otomatis (Host Linux)
```bash
git clone https://github.com/muhammadfikri-dev/nethunter-kernel-s10plus.git
cd nethunter-kernel-s10plus
chmod +x build.sh scripts/*.sh
./build.sh
```

Skrip build akan secara otomatis:
1. Memeriksa dan memasang seluruh dependensi compiler.
2. Mengunduh toolchain Proton Clang dan GCC 4.9 ARM64.
3. Melakukan clone source tree kernel branch `nethunter-lineage-23.2`.
4. Menerapkan defconfig dengan modul NetHunter.
5. Mengompilasi binary `Image.lz4-dtb` / `Image`.
6. Membungkus output ke dalam file ZIP flashable **AnyKernel3** di direktori `./output/`.

---

### Metode 2: Kompilasi Cloud Otomatis via GitHub Actions
Repositori ini telah dilengkapi dengan workflow CI/CD bawaan:
1. Buka tab **Actions** pada repositori ini di GitHub.
2. Pilih workflow **"Build NetHunter Kernel S10+"**.
3. Klik **"Run workflow"**.
4. Unduh file ZIP kernel yang telah selesai dikompilasi dari menu **Artifacts / Releases**.

---

## 📲 Panduan Flashing & Pemasangan
1. Pastikan Samsung Galaxy S10+ telah menjalankan custom ROM **LineageOS** dengan bootloader terbuka (*unlocked*).
2. Pasang custom recovery **TWRP / OrangeFox** serta **Magisk / KernelSU**.
3. Masuk ke mode Recovery.
4. Flash file ZIP yang dihasilkan (`NetHunter-Kernel-beyond2lte-*.zip`).
5. Reboot ke sistem dan buka aplikasi **Kali NetHunter**.
6. Verifikasi kernel di terminal: `uname -a`.

---

## 📄 Lisensi
Didistribusikan di bawah lisensi open-source **GNU General Public License v2 (GPL-2.0)**.
Otomasi build dibuat dengan ❤️ oleh **Muhammad Fikri Dev**.

---

<p align="center">
  Dibuat dengan ❤️ oleh <b>Muhammad Fikri Dev</b>
</p>
a
