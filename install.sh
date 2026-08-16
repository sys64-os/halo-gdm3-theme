#!/bin/bash
# Halo Cortana GDM3 (Login Screen) Installer

if [ "$EUID" -ne 0 ]; then
  echo "Error: Harap jalankan script ini sebagai root (sudo ./install.sh)"
  exit 1
fi

# Validasi file background
if [ ! -f "background.png" ]; then
    echo "Error: file background.png tidak ditemukan di folder instalasi!"
    exit 1
fi

echo ">> Menyiapkan aset background..."
mkdir -p /usr/share/backgrounds
cp background.png /usr/share/backgrounds/halo-gdm-bg.png
chmod 644 /usr/share/backgrounds/halo-gdm-bg.png

echo ">> Menginstal dependensi untuk kompilasi tema (libglib2.0-dev-bin)..."
apt-get update -qq
apt-get install -y libglib2.0-dev-bin wget

echo ">> Mengunduh GDM patching tool..."
wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background -O /tmp/ubuntu-gdm-set-background
chmod +x /tmp/ubuntu-gdm-set-background

echo ">> Menerapkan background baru ke GDM3..."
/tmp/ubuntu-gdm-set-background --image /usr/share/backgrounds/halo-gdm-bg.png

if [ $? -eq 0 ]; then
    echo "======================================================"
    echo ">> Selesai! Background GDM3 (Login Screen) telah diubah."
    echo ">> Silakan Logout atau Reboot untuk melihat hasilnya."
else
    echo "======================================================"
    echo ">> Terjadi kesalahan saat menerapkan tema GDM3."
fi
