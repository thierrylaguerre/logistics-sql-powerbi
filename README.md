# 🚛 Analyse des Opérations de Transport Routier — SQL & Power BI

> Projet portfolio Data Analyst · Secteur Logistique & Transport · 2025

## 🎯 Contexte & Objectif

### Contexte
Le secteur du transport routier génère des volumes massifs de données opérationnelles — trajets, livraisons, consommation carburant, performance des chauffeurs. L'enjeu pour un DA est de transformer ces données brutes en insights actionnables pour optimiser la rentabilité et la performance opérationnelle.

### Problématique
**Comment analyser les performances opérationnelles d'une entreprise de transport routier pour identifier les leviers d'optimisation de la rentabilité ?**

### Objectifs
- Construire une base de données SQL à partir de données logistiques réelles
- Écrire des requêtes SQL pour extraire les KPIs métier clés
- Concevoir un dashboard Power BI interactif avec mesures DAX
- Identifier les clients, routes et chauffeurs les plus performants

## 📊 Dashboard Power BI

Le dashboard est structuré en 4 pages :

### Page 1 — Analyse des Revenus
- Revenu mensuel sur 3 ans (2022-2024)
- Répartition par type de client (Contract, Spot, Dedicated)
- Top 10 clients par revenu
- KPIs : Revenu Total (604M$), Nb Chargements (85K), Revenu Moyen/Client (1.51M$)

### Page 2 — Ponctualité des Livraisons
- Top 10 routes les plus ponctuelles
- Taux de ponctualité moyen : 55.68%
- Analyse par route avec nombre de livraisons

### Page 3 — Performance des Chauffeurs
- Top 10 chauffeurs par revenu généré
- Consommation moyenne (MPG)
- Tableau détaillé avec nb trajets et revenus

### Page 4 — Coûts & Marges
- Évolution revenus vs coûts carburant
- Marge brute mensuelle
- KPIs : Coût Carburant (95.59M$), Marge Brute (508.53M$)

## 🗄️ Base de données SQL

**14 tables · 550 000+ lignes**

| Table | Description |
|---|---|
| `loads` | Chargements avec revenus et statuts |
| `trips` | Trajets avec distance, durée, carburant |
| `delivery_events` | Événements de livraison et ponctualité |
| `drivers` | Chauffeurs et leurs caractéristiques |
| `customers` | Clients et types de contrats |
| `routes` | Routes avec distances et tarifs |
| `fuel_purchases` | Achats carburant par trajet |

## 📝 Requêtes SQL clés

- Revenus par client avec jointures multi-tables
- Taux de ponctualité par route
- Performance et rentabilité par chauffeur
- Évolution mensuelle des marges (revenus - coûts carburant)
- Utilisation des camions par nombre de trajets

## 📐 Mesures DAX

```dax
Revenu Total = SUM(marge[revenu_total])
Marge Brute Total = SUM(marge[marge_brute])
Taux Marge % = DIVIDE(SUM(marge[marge_brute]), SUM(marge[revenu_total])) * 100
Taux Ponctualite Moyen = AVERAGE(ponctualite[taux_ponctualite])
Revenu Moyen Par Client = AVERAGEX(revenus_client, revenus_client[revenu_total])
```

## 🛠️ Stack technique

- **SQL** · SQLite · DBeaver
- **Python** · Pandas · sqlite3 *(import et agrégation des données)*
- **Power BI Desktop** · DAX *(dashboard et mesures)*
- **GitHub** · versioning du projet

## 🚀 Lancer le projet en local

```bash
git clone https://github.com/TON_USERNAME/logistics-sql-powerbi
cd logistics-sql-powerbi
pip install -r requirements.txt
python import_db.py
```

Puis ouvrir `dashboard_logistique.pbix` dans Power BI Desktop.

## 👤 Auteur

**Thierry** · Candidat Data Analyst Junior · Paris Île-de-France
Master Big Data Paris 8 · Licence Informatique Sorbonne Paris Nord
