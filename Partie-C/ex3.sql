-- 1. Choix technologiques
-- (a) Suivi GPS -> TimescaleDB : ingestion massive sequentielle, partitionnement horizontal et retention temporelle (TTL).
-- (b) Facturation bancaire des trajets -> PostgreSQL : conformite ACID stricte, integrite relationnelle et
--        isolation forte.
-- (c) Amis communs et itineraires a 3 degres de separation -> Neo4j : traversee rapide des relations multi-sauts sans jointures couteuses.

-- 2. Justification CAP & PACELC
-- (a) GPS -> AP / EL : disponibilite (A) en cas de partition et faible atence (L) en temps normal ; coherence eventuelle suffisante.
-- (b) Facturation -> CP / EC : coherence forte (C) prioritaire en cas de artition comme en temps normal pour eviter toute erreur financiere.
-- (c) Graphe -> CP / EC : coherence forte (C) pour garantir l'integrite es liens et des parcours.

-- 3. Les 4 criteres de choix
-- 1) Modele de donnees : series temporelles , relationnel normalise (facturation), graphe noeuds/aretes (reseau social / trajets).
-- 2) Volume & velocite : ~864M points GPS/jour (fort debit d'ecriture) vs volumes plus faibles mais critiques en facturation et graphe.
-- 3) Requetes : append-only et plages temporelles, transactions et facturation, traversées en profondeur (graphe).
-- 4) Coherence & integrite : eventuelle  vs ACID strict (facturation et relations du graphe).