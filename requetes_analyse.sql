-- Aperçu des chargements
SELECT 
    load_id,
    customer_id,
    load_date,
    load_type,
    weight_lbs,
    revenue,
    load_status
FROM loads
LIMIT 10;

-- Revenu total par client (Top 10)
SELECT 
    c.customer_name,
    c.customer_type,
    COUNT(l.load_id) AS nb_chargements,
    ROUND(SUM(l.revenue), 2) AS revenu_total,
    ROUND(AVG(l.revenue), 2) AS revenu_moyen
FROM loads l
JOIN customers c ON l.customer_id = c.customer_id
GROUP BY c.customer_name, c.customer_type
ORDER BY revenu_total DESC
LIMIT 10;

-- Taux de livraison à l'heure par route
SELECT 
    r.origin_city,
    r.destination_city,
    COUNT(d.event_id) AS nb_livraisons,
    ROUND(SUM(CASE WHEN d.on_time_flag = 'True' THEN 1 ELSE 0 END) * 100.0 / COUNT(d.event_id), 1) AS taux_ponctualite
FROM delivery_events d
JOIN trips t ON d.trip_id = t.trip_id
JOIN loads l ON t.load_id = l.load_id
JOIN routes r ON l.route_id = r.route_id
GROUP BY r.origin_city, r.destination_city
ORDER BY taux_ponctualite DESC
LIMIT 10;

-- Top 10 chauffeurs par revenu généré
SELECT 
    d.first_name || ' ' || d.last_name AS chauffeur,
    d.employment_status,
    COUNT(t.trip_id) AS nb_trajets,
    ROUND(SUM(l.revenue), 2) AS revenu_total,
    ROUND(AVG(t.actual_distance_miles), 1) AS distance_moyenne_miles
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id
JOIN loads l ON t.load_id = l.load_id
GROUP BY chauffeur, d.employment_status
ORDER BY revenu_total DESC
LIMIT 10;

-- Routes les plus rentables
SELECT 
    r.origin_city || ' → ' || r.destination_city AS route,
    r.typical_distance_miles AS distance_miles,
    COUNT(l.load_id) AS nb_chargements,
    ROUND(SUM(l.revenue), 2) AS revenu_total,
    ROUND(SUM(l.revenue) / SUM(t.actual_distance_miles), 2) AS revenu_par_mile
FROM loads l
JOIN routes r ON l.route_id = r.route_id
JOIN trips t ON l.load_id = t.load_id
GROUP BY route, r.typical_distance_miles
ORDER BY revenu_par_mile DESC
LIMIT 10;

-- Évolution du revenu mensuel
SELECT 
    STRFTIME('%Y-%m', load_date) AS mois,
    COUNT(load_id) AS nb_chargements,
    ROUND(SUM(revenue), 2) AS revenu_total,
    ROUND(AVG(revenue), 2) AS revenu_moyen
FROM loads
GROUP BY mois
ORDER BY mois;

-- Coût carburant vs revenu par mois
SELECT 
    STRFTIME('%Y-%m', t.dispatch_date) AS mois,
    ROUND(SUM(l.revenue), 2) AS revenu_total,
    ROUND(SUM(f.total_cost), 2) AS cout_carburant,
    ROUND(SUM(l.revenue) - SUM(f.total_cost), 2) AS marge_brute,
    ROUND(SUM(f.total_cost) / SUM(l.revenue) * 100, 1) AS part_carburant_pct
FROM trips t
JOIN loads l ON t.load_id = l.load_id
JOIN fuel_purchases f ON t.trip_id = f.trip_id
GROUP BY mois
ORDER BY mois;

-- Axe 3 : Taux d'utilisation des camions
SELECT 
    t.truck_id,
    tk.make,
    tk.model_year,
    tk.status,
    COUNT(t.trip_id) AS nb_trajets,
    ROUND(AVG(t.actual_distance_miles), 1) AS distance_moyenne,
    ROUND(AVG(t.average_mpg), 2) AS consommation_moyenne
FROM trips t
JOIN trucks tk ON t.truck_id = tk.truck_id
GROUP BY t.truck_id, tk.make, tk.model_year, tk.status
ORDER BY nb_trajets DESC
LIMIT 10;

-- Axe 4 : Clients inactifs à risque
SELECT 
    customer_name,
    customer_type,
    account_status,
    annual_revenue_potential,
    contract_start_date
FROM customers
WHERE account_status = 'Inactive'
ORDER BY annual_revenue_potential DESC
LIMIT 10;

SELECT on_time_flag, COUNT(*) 
FROM delivery_events 
GROUP BY on_time_flag;