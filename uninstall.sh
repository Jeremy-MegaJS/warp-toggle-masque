#!/usr/bin/env bash
set -euo pipefail
rm -f "$HOME/.local/bin/warp-toggle-masque"
rm -f "$HOME/.local/share/applications/cloudflare-warp-masque-toggle.desktop"
echo 'Se eliminó el conmutador MASQUE y su lanzador.'
echo 'No se eliminó Cloudflare WARP, su servicio, sus registros ni la configuración WireGuard anterior.'
