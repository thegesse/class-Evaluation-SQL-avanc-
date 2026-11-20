WITH RECURSIVE organigramme AS (
    SELECT id, nom, poste, manager_id,
        1 AS niveau,
        nom::text AS chemin
    FROM employes
    WHERE manager_id IS NULL
    UNION ALL
    SELECT 
        e.id,
        e.nom,
        e.poste,
        e.manager_id,
        o.niveau + 1 AS niveau,
        (o.chemin || ' > ' || e.nom)::text AS chemin
    FROM employes e
    INNER JOIN organigramme o ON e.manager_id = o.id
)

SELECT id, nom, poste, niveau, chemin
FROM organigramme
ORDER BY chemin ASC;