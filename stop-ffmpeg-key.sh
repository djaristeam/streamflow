#!/bin/bash

# Ganti ini dengan kunci live / stream key yang ingin dihentikan
TARGET_KEY="$1"

if [ -z "$TARGET_KEY" ]; then
  echo "⚠️  Gunakan: ./stop-ffmpeg-key.sh <stream-key>"
  exit 1
fi

# Cari PID ffmpeg yang memuat stream key tersebut
PIDS=$(ps aux | grep ffmpeg | grep "$TARGET_KEY" | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
  echo "✅ Tidak ada proses ffmpeg ditemukan dengan key: $TARGET_KEY"
  exit 0
fi

echo "🔍 Ditemukan proses ffmpeg dengan key '$TARGET_KEY':"
echo "$PIDS"

# Hentikan semua proses yang cocok
for PID in $PIDS; do
  echo "⛔ Menghentikan PID: $PID"
  kill -9 $PID
done

echo "✅ Semua proses ffmpeg dengan key '$TARGET_KEY' sudah dihentikan."
