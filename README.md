# Cloudflare WARP Toggle — MASQUE

**Bilingual project documentation / Documentación bilingüe**

A lightweight graphical utility for KDE Plasma on Arch Linux. It controls the official Cloudflare WARP client on demand through \`warp-cli\`, checks daemon state, and verifies connectivity after connecting.

Utilidad gráfica ligera para KDE Plasma en Arch Linux. Controla bajo demanda el cliente oficial de Cloudflare WARP mediante \`warp-cli\`, comprueba el estado del servicio y verifica la conectividad después de conectarse.

## Features / Funcionalidades

- KDE dialog to connect or disconnect the official WARP client.
- Checks whether the \`warp-svc\` daemon is active.
- Reads connection status through \`warp-cli\`.
- Verifies the resulting connection through Cloudflare's public diagnostic endpoint and checks for \`warp=on\`.
- Writes a local diagnostic log to \`~/.cache/warp-toggle-masque.log\`.
- Detects a legacy WireGuard interface named \`warp\` and stops to avoid running both VPN paths simultaneously.
- Includes user-level installation and uninstallation scripts.

- Diálogo de KDE para conectar o desconectar el cliente oficial de WARP.
- Comprueba si el servicio \`warp-svc\` está activo.
- Consulta el estado de conexión mediante \`warp-cli\`.
- Verifica la conexión con el endpoint público de diagnóstico de Cloudflare y comprueba el valor \`warp=on\`.
- Guarda un registro local en \`~/.cache/warp-toggle-masque.log\`.
- Detecta una interfaz WireGuard heredada llamada \`warp\` y se detiene para evitar ejecutar ambas rutas VPN simultáneamente.
- Incluye scripts de instalación y desinstalación para el usuario.

## Technology / Tecnologías

- Bash
- Official Cloudflare WARP CLI
- MASQUE tunnel protocol
- KDialog / KDE Plasma
- systemd
- curl, iproute2, grep, and sed

## Requirements / Requisitos

- Linux with systemd and KDE Plasma (or KDialog).
- Official Cloudflare WARP client installed and registered.
- \`warp-cli\`, \`warp-svc\`, \`curl\`, \`ip\`, \`grep\`, \`sed\`, and \`systemctl\`.
- MASQUE configured in the official WARP client.

- Linux con systemd y KDE Plasma (o KDialog).
- Cliente oficial de Cloudflare WARP instalado y registrado.
- \`warp-cli\`, \`warp-svc\`, \`curl\`, \`ip\`, \`grep\`, \`sed\` y \`systemctl\`.
- MASQUE configurado en el cliente oficial de WARP.

This utility does not install WARP, create Cloudflare accounts, register devices, or manage Cloudflare policies.

Esta utilidad no instala WARP, crea cuentas de Cloudflare, registra dispositivos ni administra políticas de Cloudflare.

## Installation / Instalación

From the repository directory / Desde la carpeta del repositorio:

~~~bash
chmod +x install.sh uninstall.sh
./install.sh
~~~

The installer places the program at \`~/.local/bin/warp-toggle-masque\` and creates a desktop launcher under \`~/.local/share/applications/\`. It does not replace the legacy \`~/.local/bin/warp-toggle\` command.

El instalador coloca el programa en \`~/.local/bin/warp-toggle-masque\` y crea un acceso directo en \`~/.local/share/applications/\`. No reemplaza el comando anterior \`~/.local/bin/warp-toggle\`.

## Usage / Uso

Launch **Cloudflare WARP (MASQUE)** from the KDE application menu or run:

Inicia **Cloudflare WARP (MASQUE)** desde el menú de aplicaciones de KDE o ejecuta:

~~~bash
~/.local/bin/warp-toggle-masque
~~~

Manual diagnostics / Diagnóstico manual:

~~~bash
warp-cli --accept-tos status
warp-cli --accept-tos settings
curl -4 -fsS --connect-timeout 5 --max-time 12 \
  https://www.cloudflare.com/cdn-cgi/trace | grep -E '^(ip|warp|gateway)='
~~~

To uninstall / Para desinstalar:

~~~bash
./uninstall.sh
~~~

The uninstall script removes this project's launcher and installed script. It does not uninstall the official WARP client or delete its configuration.

El desinstalador elimina el acceso directo y el script instalado por este proyecto. No desinstala el cliente oficial de WARP ni elimina su configuración.

## Design and scope / Diseño y alcance

The utility is a small control layer over the existing official WARP client. It does not modify DNS settings, NetworkManager profiles, firewall rules, WireGuard configuration files, or automatic-start services.

La utilidad es una pequeña capa de control sobre el cliente oficial de WARP. No modifica la configuración DNS, los perfiles de NetworkManager, las reglas del firewall, los archivos de configuración de WireGuard ni los servicios de inicio automático.

## Privacy / Privacidad

The repository does not require private keys, access tokens, VPS credentials, or personal network configuration. When connecting, the utility makes an HTTPS request to Cloudflare's public diagnostic endpoint to verify the WARP state.

El repositorio no necesita claves privadas, tokens de acceso, credenciales de VPS ni configuraciones personales de red. Al conectarse, la utilidad realiza una solicitud HTTPS al endpoint público de diagnóstico de Cloudflare para verificar el estado de WARP.

## Project status / Estado

A small utility packaged for Arch Linux and KDE Plasma. Compatibility may vary across Linux distributions, WARP client versions, and desktop environments.

Utilidad pequeña preparada para Arch Linux y KDE Plasma. La compatibilidad puede variar según la distribución de Linux, la versión del cliente WARP y el entorno de escritorio.

## Author / Autor

Jeremy Torres — [GitHub](https://github.com/Jeremy-MegaJS)
