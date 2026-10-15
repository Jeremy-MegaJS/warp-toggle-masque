# Cloudflare WARP Toggle — MASQUE

Pequeño conmutador gráfico para KDE Plasma en Arch Linux. Usa `kdialog` para conectar o desconectar el **cliente oficial de Cloudflare WARP** mediante `warp-cli`. Está pensado para la configuración MASQUE probada en este equipo.

## Qué incluye

- Diálogo gráfico para conectar y desconectar el cliente oficial.
- Comprueba que `warp-svc` esté activo antes de hacer cambios.
- Comprueba el estado informado por `warp-cli`.
- Después de conectar, intenta verificar el tráfico real mediante `https://www.cloudflare.com/cdn-cgi/trace` y busca `warp=on`.
- Guarda su registro en `~/.cache/warp-toggle-masque.log`.
- Detecta la antigua interfaz WireGuard `warp` y se detiene para evitar ejecutar ambas VPN simultáneamente.
- Instalador y desinstalador de usuario; no requieren privilegios para instalar el lanzador.

## Qué no hace

- No instala el cliente Cloudflare WARP ni acepta términos por el usuario.
- No crea ni administra una cuenta, registro o política de Cloudflare.
- No modifica DNS, NetworkManager, reglas de firewall ni `/etc/wireguard/warp.conf`.
- No instala servicios de inicio automático.
- No garantiza que WARP funcione en redes que bloqueen el protocolo o sus endpoints.

## Requisitos

- Linux con `systemd` y escritorio KDE Plasma (o `kdialog` instalado).
- Cliente oficial Cloudflare WARP instalado y registrado: `warp-cli`, `warp-svc`.
- `curl`, `ip`, `grep`, `sed`, `systemctl`, `bash`.
- Protocolo MASQUE ya configurado en el cliente, por ejemplo:

  ```bash
  warp-cli --accept-tos tunnel protocol set MASQUE
  ```

  El cliente puede solicitar la aceptación de sus términos durante el registro o ciertas operaciones. Lee y acepta los términos directamente antes de continuar.

## Instalación

Desde el directorio del proyecto:

```bash
chmod +x install.sh uninstall.sh
./install.sh
```

Esto instala el programa en `~/.local/bin/warp-toggle-masque` y crea un lanzador en `~/.local/share/applications/`. No reemplaza el antiguo `~/.local/bin/warp-toggle`.

Comprueba que el daemon esté activo:

```bash
systemctl status warp-svc --no-pager
```

Si no está activo, un administrador puede iniciarlo con:

```bash
sudo systemctl enable --now warp-svc
```

## Uso

Abre **Cloudflare WARP (MASQUE)** desde el menú de aplicaciones, o ejecuta:

```bash
~/.local/bin/warp-toggle-masque
```

Diagnóstico manual:

```bash
warp-cli --accept-tos status
warp-cli --accept-tos settings
curl -4 -fsS --connect-timeout 5 --max-time 12 \
  https://www.cloudflare.com/cdn-cgi/trace | grep -E '^(ip|warp|gateway)='
```

Desinstalación del conmutador:

```bash
./uninstall.sh
```

Esto no desinstala el cliente WARP ni elimina datos de configuración.

## Seguridad y privacidad

Este proyecto no contiene claves privadas, tokens ni configuración de VPS. El instalador solo copia un script y un lanzador a la carpeta del usuario. El script realiza llamadas al cliente WARP instalado localmente y una petición HTTPS al endpoint público de diagnóstico de Cloudflare al conectar.

## Estado

Versión inicial empaquetada a partir del flujo probado en Arch Linux + KDE Plasma. Probado con validación de sintaxis de Bash; no sustituye una prueba en cada distribución, versión del cliente o entorno de escritorio.
