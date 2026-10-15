#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
APP_DIR="${HOME}/.local/share/applications"
TARGET="${BIN_DIR}/warp-toggle-masque"
DESKTOP="${APP_DIR}/cloudflare-warp-masque-toggle.desktop"

for file in "$ROOT/src/warp-toggle-masque"; do
    [[ -f "$file" ]] || { echo "No encuentro $file" >&2; exit 1; }
done

mkdir -p "$BIN_DIR" "$APP_DIR"
if [[ -e "$TARGET" ]]; then
    cp -a "$TARGET" "${TARGET}.backup-$(date +%Y%m%d-%H%M%S)"
    echo "Copia del ejecutable anterior creada."
fi
install -m 0755 "$ROOT/src/warp-toggle-masque" "$TARGET"

cat > "$DESKTOP" <<DESKTOP_EOF
[Desktop Entry]
Name=Cloudflare WARP (MASQUE)
Comment=Conectar o desconectar el cliente oficial Cloudflare WARP
Exec=$TARGET
Icon=network-vpn
Terminal=false
Type=Application
Categories=Network;Security;
StartupNotify=true
DESKTOP_EOF
chmod 0644 "$DESKTOP"

printf 'Instalado: %s\nLanzador: %s\n' "$TARGET" "$DESKTOP"
printf '\nRequisitos: cliente oficial Cloudflare WARP (warp-cli/warp-svc), systemd, kdialog y curl.\n'
printf 'Este instalador no instala WARP, no cambia DNS y no modifica wg-quick.\n'
