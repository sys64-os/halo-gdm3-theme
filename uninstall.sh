#!/bin/bash
# Halo Cortana GDM3 Uninstaller (Reset to Default)

if [ "$EUID" -ne 0 ]; then
  echo "Error: Harap jalankan script ini sebagai root (sudo ./uninstall.sh)"
  exit 1
fi

echo ">> Mengunduh GDM patching tool untuk reset..."
wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background -O /tmp/ubuntu-gdm-set-background
chmod +x /tmp/ubuntu-gdm-set-background

echo ">> Mengembalikan GDM3 ke pengaturan default bawaan Ubuntu..."
/tmp/ubuntu-gdm-set-background --reset

if [ $? -eq 0 ]; then
    echo ">> Menghapus file background kustom..."
    rm -f /usr/share/backgrounds/halo-gdm-bg.png
    
    echo "======================================================"
    echo ">> Uninstall Selesai! Login screen kembali ke default Ubuntu."
    echo ">> Silakan Logout atau Reboot untuk melihat hasilnya."
else
    echo "======================================================"
    echo ">> Terjadi kesalahan saat mereset tema GDM3."
fi
