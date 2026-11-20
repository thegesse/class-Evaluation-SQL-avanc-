WITH classement_produits AS (
    SELECT 
        p.id,
        p.nom,
        c.nom AS categorie,
        p.prix_unitaire,
        DENSE_RANK() OVER (
            PARTITION BY p.categorie_id 
            ORDER BY p.prix_unitaire DESC
        ) AS rang
    FROM produits p
    JOIN categories c ON p.categorie_id = c.id
)
SELECT categorie, rang, id, nom, prix_unitaire
FROM classement_produits
WHERE rang <= 2
ORDER BY categorie ASC, rang ASC, prix_unitaire DESC;