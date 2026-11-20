-- Sous READ COMMITTED: Chaque requête SELECT lit les dernières données validées. 
-- Si on lit un solde de 1000 €, que requête 2 le passe à 800 € et fait COMMIT, 
-- la seconde lecture de requête 1 renvoie 800 €.
-- Résolution sous REPEATABLE READ : PostgreSQL fige un instantané
-- au début de requête 1. Même après le COMMIT de requête 2, la seconde lecture de requête 1 renvoie toujours 1000 €.

-- Le WAL (Write-Ahead Log) enregistre séquentiellement toute modification sur disque avant 
-- qu'elle ne soit écrite dans les fichiers de données principaux: coupure avant le COMMIT coupure apres le COMMIT