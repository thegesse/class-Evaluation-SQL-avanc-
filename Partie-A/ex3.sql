CREATE UNIQUE INDEX idx_mv_synthese_segments_segment
ON mv_synthese_segments (segment);

CREATE MATERIALIZED VIEW mv_synthese_segments AS
SELECT 
    cl.segment,
    COUNT(co.id) AS nb_commandes,
    COALESCE(SUM(co.montant_total), 0) AS ca_total
FROM clients cl
LEFT JOIN commandes co ON co.client_id = cl.id
GROUP BY cl.segment
WITH DATA;

-- Insertion d'une commande test en 2026 obsolete
INSERT INTO commandes (client_id, date_commande, montant_total, statut)
VALUES (1, '2026-11-20 10:00:00', 10000.00, 'LIVREE');

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_synthese_segments;

-- si materialized view existe deja DROP MATERIALIZED VIEW IF EXISTS mv_synthese_segments;