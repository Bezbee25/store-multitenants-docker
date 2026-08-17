# Déploiement — Store Multitenants (WoxxApp)

Ce dépôt contient la configuration de déploiement Docker pour l'application **Store Multitenants**.

## Pré-requis

- Réseau Docker `woxxapp-network` actif
- Réseau Docker `woxxpay_private_api` actif (si paiement activé)
- Base de données PostgreSQL accessible

## Mise en route rapide

```bash
# 1. Configurer l'environnement
make setup
# Éditer le fichier .env avec les identifiants requis

# 2. Lancer les conteneurs
make start

# 3. Vérifier les logs
make logs
```

## Maintenance & Mises à jour

- `make update` : Télécharge les dernières images depuis `ghcr.io` et relance les conteneurs
- `make cron-install` : Installe le cron de mise à jour automatique (toutes les 6 heures)
- `make cron-remove` : Désinstalle le cron
