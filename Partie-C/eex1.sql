-- toute comparaison directe avec NULL (id <> NULL) évalue toujours à UNKNOWN (et non TRUE). 
-- En boolean, la conjonction TRUE AND TRUE AND UNKNOWN donne UNKNOWN. 
-- Comme la clause WHERE ne conserve que les lignes évaluées strictement à TRUE, la requête renvoie systématiquement 0 ligne 
-- dès lors qu'au moins un employé a manager_id IS NULL.

--correction: 
SELECT e.id, e.nom
FROM employes e
WHERE NOT EXISTS (
    SELECT 1
    FROM employes sub
    WHERE sub.manager_id = e.id
);