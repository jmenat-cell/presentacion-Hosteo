#!/usr/bin/env bash
# Renderiza un HTML a PDF con Chromium headless.
# Uso: scripts/html2pdf.sh entrada.html salida.pdf
# El tamaño de página lo controla el @page del HTML (deck 1280×720 o A4).
set -euo pipefail

ENTRADA="${1:?Uso: scripts/html2pdf.sh entrada.html salida.pdf}"
SALIDA="${2:?Uso: scripts/html2pdf.sh entrada.html salida.pdf}"

BIN="${CHROMIUM_BIN:-}"
if [ -z "$BIN" ]; then
  for candidato in /opt/pw-browsers/chromium chromium chromium-browser google-chrome google-chrome-stable; do
    if command -v "$candidato" >/dev/null 2>&1; then BIN="$candidato"; break; fi
  done
fi
if [ -z "$BIN" ]; then
  echo "No se encontró Chromium/Chrome. Instálalo o define CHROMIUM_BIN=/ruta/al/binario" >&2
  exit 1
fi

"$BIN" --headless=new --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$SALIDA" "file://$(realpath "$ENTRADA")" 2>/dev/null

echo "PDF generado: $SALIDA"
