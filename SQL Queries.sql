--Primary Key pour players
ALTER TABLE players
ADD PRIMARY KEY (player_id);

--Join entre players et apparences
SELECT *
FROM players
JOIN apparences ON players.player_id = apparences.player_id;

-- On récupère l'âge des joueurs pour chercher les pépites
SELECT name, country_of_birth, date_of_birth, AGE(NOW(), date_of_birth) AS age from players ORDER BY age ASC;


-- Nous donne la somme des buts et assists par nom de joueur sur l'année en cours
SELECT player_name, SUM (goals) AS total_goals, SUM (assists) AS total_assists
FROM appearances
WHERE date BETWEEN '2022-01-01' AND '2023-12-12'
GROUP BY player_name
ORDER BY total_goals DESC;

--Ajoute dans apparences, les stats requises pour nos calculs à venir
INSERT INTO apparences
SELECT player_id, SUM(goals), SUM(assists), SUM(minutes_played)
FROM appearances
GROUP BY player_id;

--Affichage des joueurs ayant les plus grosses stats par âge
SELECT players.name, apparences.goals, apparences.assists, apparences.minutes_played, players.position, AGE(NOW(), players.date_of_birth) AS age
FROM players 
JOIN apparences ON players.player_id = apparences.player_id
WHERE AGE(NOW(), players.date_of_birth) < interval '19 years'
ORDER BY goals DESC;

-- Affichage des jeunes joueurs défenseurs qui dépassent une certaine taille
SELECT players.name, apparences.goals, apparences.assists, apparences.minutes_played, players.position, players.height_in_cm, AGE(NOW(), players.date_of_birth) AS age
FROM players 
JOIN apparences ON players.player_id = apparences.player_id
WHERE AGE(NOW(), players.date_of_birth) < interval '19 years' AND players.position = 'Defender' AND height_in_cm >= '188'
ORDER BY goals DESC;

-- Affichage des joueurs défenseurs qui dépassent une certaine taille ET qui ont fait leur dernière saison en 2021 (Agents libres)
SELECT players.name, apparences.goals, apparences.assists, apparences.minutes_played, players.position, players.height_in_cm, AGE(NOW(), players.date_of_birth) AS age
FROM players 
JOIN apparences ON players.player_id = apparences.player_id
WHERE AGE(NOW(), players.date_of_birth) < interval '30 years' AND players.position = 'Defender' AND height_in_cm >= '188' AND players.last_season = '2021'
ORDER BY goals DESC;


-- Affichage des joueurs qui ont une valeur marchande de moins d'1 M€, qui ont joué plus de 10000 minutes et qui ont un contrat qui expire avant le 1er janvier 2025 avec seulement les 10 joueurs ayant marqué le plus de buts
SELECT players.name, apparences.goals, apparences.assists, apparences.minutes_played, players.position, players.height_in_cm, players.market_value_in_eur, AGE(NOW(), players.date_of_birth) AS age, players.contract_expiration_date
FROM players 
JOIN apparences ON players.player_id = apparences.player_id
WHERE AGE(NOW(), players.date_of_birth) < interval '30 years' AND players.market_value_in_eur <= '1000000' AND minutes_played >= '10000' AND contract_expiration_date <= '2025-01-01'
ORDER BY goals DESC
LIMIT 10;
