.PHONY: help setup login start stop restart logs status update down cron-install cron-remove

COMPOSE_DIR := $(shell pwd)
CRON_CMD    := $(COMPOSE_DIR)/scripts/update.sh
CRON_LOG    := $(COMPOSE_DIR)/logs/update.log

help:
	@echo ""
	@echo "  store-multitenants -- Commandes de déploiement"
	@echo "  make setup          Initialise .env + dossier logs"
	@echo "  make login          Authentification ghcr.io"
	@echo "  make start          Lance les containers"
	@echo "  make stop           Arrête les containers"
	@echo "  make restart        Redémarre les containers"
	@echo "  make logs           Logs en temps réel"
	@echo "  make status         État des containers"
	@echo "  make update         Pull nouvelles images + relance"
	@echo "  make down           Arrête et supprime les containers"
	@echo "  make cron-install   Active la mise à jour automatique (6h)"
	@echo "  make cron-remove    Désactive la mise à jour automatique"
	@echo ""

setup:
	@test -f .env || cp .env.example .env
	@mkdir -p logs
	@echo "Setup terminé (.env et logs/ créés)"

login:
	docker login ghcr.io

start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

logs:
	docker compose logs -f --tail=100

status:
	docker compose ps

update:
	docker compose pull
	docker compose up -d --force-recreate

down:
	docker compose down

cron-install:
	@chmod +x $(CRON_CMD)
	@mkdir -p $(COMPOSE_DIR)/logs
	@( crontab -l 2>/dev/null | grep -v "$(CRON_CMD)" ; \
	   echo "0 */6 * * * $(CRON_CMD) >> $(CRON_LOG) 2>&1" ) | crontab -
	@echo "Cron installé : vérification toutes les 6 heures"
	@crontab -l | grep "$(CRON_CMD)"

cron-remove:
	@( crontab -l 2>/dev/null | grep -v "$(CRON_CMD)" ) | crontab - || true
	@echo "Cron supprimé"
