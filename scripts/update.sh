#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_DIR="$(dirname "$SCRIPT_DIR")"

cd "$COMPOSE_DIR"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Vérification des mises à jour d'images..."
docker compose pull
docker compose up -d --force-recreate
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Mise à jour terminée."
