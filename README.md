# Cloudflare WARP Toggle — MASQUE

A lightweight graphical utility for KDE Plasma on Arch Linux. It provides a desktop dialog to connect or disconnect the official Cloudflare WARP client through `warp-cli`, with service-state checks and a post-connection connectivity verification.

The project focuses on convenient, on-demand VPN control without adding another always-running application.

## Key Features

- KDE dialog for connecting and disconnecting the official WARP client.
- Checks whether the `warp-svc` daemon is active before making changes.
- Reads connection status through `warp-cli`.
- Verifies the resulting connection using Cloudflare's public diagnostic endpoint and checks for `warp=on`.
- Stores a local diagnostic log at `~/.cache/warp-toggle-masque.log`.
- Detects a legacy WireGuard interface named `warp` and stops to avoid running both VPN paths simultaneously.
- Includes user-level installation and uninstallation scripts.

## Technology

- **Bash** — application logic and setup scripts.
- **Cloudflare WARP CLI** — connection control and status reporting.
- **MASQUE** — tunnel protocol configured in the official client.
- **KDialog / KDE Plasma** — graphical interface.
- **systemd** — daemon-state checks.
- **curl, ip, grep, sed** — connectivity verification and system inspection.

## Requirements

- Linux with `systemd` and KDE Plasma (or `kdialog`).
- The official Cloudflare WARP client installed and registered.
- `warp-cli`, `warp-svc`, `curl`, `ip`, `grep`, `sed`, and `systemctl`.
- MASQUE configured in the WARP client.

This utility does not install WARP, create Cloudflare accounts, register devices, or manage Cloudflare policies.

## Installation

From the project directory:

```bash
chmod +x install.sh uninstall.sh
./install.sh
```

The installer places the program at `~/.local/bin/warp-toggle-masque` and creates a desktop launcher under `~/.local/share/applications/`. It does not replace the legacy `~/.local/bin/warp-toggle` command.

Check that the official daemon is active:

```bash
systemctl status warp-svc --no-pager
```

If it is not running, an administrator can start it:

```bash
sudo systemctl enable --now warp-svc
```

## Usage

Launch **Cloudflare WARP (MASQUE)** from the KDE application menu or run:

```bash
~/.local/bin/warp-toggle-masque
```

For manual diagnostics:

```bash
warp-cli --accept-tos status
warp-cli --accept-tos settings
curl -4 -fsS --connect-timeout 5 --max-time 12 \
  https://www.cloudflare.com/cdn-cgi/trace | grep -E '^(ip|warp|gateway)='
```

To uninstall this utility:

```bash
./uninstall.sh
```

The uninstall script removes this project's launcher and installed script. It does not uninstall the official WARP client or delete its configuration.

## Design and Scope

The utility is intentionally a small control layer over the existing official WARP client. It does not modify DNS settings, NetworkManager profiles, firewall rules, WireGuard configuration files, or automatic-start services.

## Privacy

The repository does not include private keys, access tokens, VPS credentials, or personal network configuration. When connecting, the utility makes an HTTPS request to Cloudflare's public diagnostic endpoint to verify the WARP state.

## Project Status

Initial utility packaged for Arch Linux and KDE Plasma. The original project notes report Bash syntax validation; behavior may vary across Linux distributions, WARP client versions, and desktop environments.

## Author

Developed by **Jeremy** — [GitHub](https://github.com/Jeremy-MegaJS).
