CREATE INDEX idx_commandes_esr
ON commandes (statut, montant_total DESC, date_commande)
INCLUDE (id, client_id);

SELECT id, client_id, date_commande, montant_total FROM commandes 
WHERE statut = 'LIVREE'
  AND date_commande >= '2026-01-01'
  AND date_commande < '2027-01-01'
ORDER BY montant_total DESC
LIMIT 10;

-- Le coût total chute drastiquement en passant d'un balayage complet et d'un tri global de toute la table (Seq Scan + Sort) 
-- à un Index Only Scan ciblé, car le Partition Pruning permet à PostgreSQL d'ignorer physiquement les partitions des années 2024 
-- et 2025 pour ne lire que la partition commandes_2026.