EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total FROM commandes 
WHERE statut = 'LIVREE'
  AND EXTRACT(YEAR FROM date_commande) = 2026
ORDER BY montant_total DESC
LIMIT 10;

-- Les  defauts de ce code sont que l'on execute un balayage sequenciel commplet a cause de la commande date_commande;
-- et le tri est couteux car on a aucun index.

