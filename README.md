# Portfolio

##SQL Queries

L'objectif de ces queries est de déterminer quels sont les joueurs de football les plus intéressants à recruter pour un club. On part du principe que le club n'a aucun outil pour l'aider dans son recrutement. Afin de réaliser ces analyses, je me suis procuré le jeu de données : https://www.kaggle.com/datasets/davidcariboo/player-scores. Ce jeu de données recense plus de 30k joueurs, avec différentes informations comme le nombre de buts, de passes décisives, de minutes jouées... Le jeu de données est séparé en plusieurs fichiers distincts. Pour nos opérations, j'ai importé sur Postgresql les fichiers : Appearances et Players.

La première étape a été de créer une nouvelle table que j'ai appelé Apparences. J'ai effectué cette opération car il m'était impossible de relier appearances et players : le player_id dans appearances apparaissait plusieurs fois, il m'était impossible d'avoir une Primary Key pour lier les deux tables. J'ai donc créé cette nouvelle table Apparences en réalisant un group_by des player_id, tout en récupérant les informations importantes qui n'étaient pas présentes dans Players.

Ensuite, j'ai join les tables apparences et players afin de réaliser mes queries.
