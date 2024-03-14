--a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et 
--réalisateur
SELECT
	film.titre_film,
	film.annee_de_sortie,
	film.duree_film, -- obtenir le format HH:MM remplacer par :  TIME_FORMAT(SEC_TO_TIME(film.duree_film * 60), '%Hh%imin') AS dure_film,
	personne.nom,
	personne.prenom
	FROM film
INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON realisateur.id_personne = personne.id_personne
WHERE film.id_film = 1
 
--b. Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)

SELECT 
	film.titre_film,
	film.duree_film
FROM film 
WHERE film.duree_film > 135
ORDER BY film.duree_film DESC 

--c. Liste des films d’un réalisateur (en précisant l’année de sortie) 

SELECT 
	film.titre_film,
	film.annee_de_sortie
	FROM film 
INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON realisateur.id_personne = personne.id_personne
WHERE film.id_realisateur = 3


--d. Nombre de films par genre (classés dans l’ordre décroissant)

SELECT 
	genre_film.libelle, COUNT(film.id_film) AS nbrFilm
	FROM genre_film
	INNER JOIN categorie ON categorie.id_genre_film = genre_film.id_genre_film
	INNER JOIN film ON film.id_film = categorie.id_film
	GROUP BY genre_film.libelle 
	ORDER BY genre_film.libelle DESC;

--e. Nombre de films par réalisateur (classés dans l’ordre décroissant)

SELECT 
	personne.prenom,
	personne.nom, 
	COUNT(film.id_film) AS nbrFilm
	FROM film
	INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
	INNER JOIN personne ON realisateur.id_personne = personne.id_personne
	GROUP BY realisateur.id_realisateur
	ORDER BY realisateur.id_realisateur DESC;

--f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe

SELECT
	
	personne.prenom,
	personne.nom,
	personne.sexe
	FROM film
	INNER JOIN casting ON film.id_film = casting.id_film
	INNER JOIN acteur ON casting.id_acteur = acteur.id_acteur
	INNER JOIN personne ON acteur.id_personne = personne.id_personne
	WHERE film.id_film = 2


--g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de 
--sortie (du film le plus récent au plus ancien)

SELECT
	
	film.titre_film,
	film.annee_de_sortie,
	rolefilm.nom_role
	FROM film
	INNER JOIN casting ON film.id_film = casting.id_film
	INNER JOIN rolefilm ON casting.id_role = rolefilm.id_role
	INNER JOIN acteur ON casting.id_acteur = acteur.id_acteur
	INNER JOIN personne ON acteur.id_personne = personne.id_personne
	WHERE acteur.id_acteur = 1
	ORDER BY film.annee_de_sortie DESC 

--h. Liste des personnes qui sont à la fois acteurs et réalisateurs

SELECT
	personne.nom,
	personne.prenom
	FROM personne
	INNER JOIN realisateur ON personne.id_personne = realisateur.id_personne
	INNER JOIN acteur ON personne.id_personne = acteur.id_personne
	GROUP BY personne.nom, personne.prenom

--i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)
SELECT
    titre_film,
    annee_de_sortie
FROM
    film
WHERE
    annee_de_sortie >= YEAR(CURDATE()) - 5
ORDER BY
    annee_de_sortie DESC;

ou mais moins bien

SELECT
	film.titre_film,
	film.annee_de_sortie
	FROM film
	WHERE annee_de_sortie BETWEEN 2019 AND 2024
	ORDER BY film.annee_de_sortie DESC; 

--j. Nombre d’hommes et de femmes parmi les acteurs

SELECT
	personne.sexe, COUNT(personne.sexe) AS nbr
	FROM acteur
	INNER JOIN personne ON acteur.id_personne = personne.id_personne
	GROUP BY personne.sexe


--k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)

SELECT
	 personne.prenom,
	 personne.nom
	 FROM acteur
	 INNER JOIN personne ON acteur.id_personne = personne.id_personne
	 WHERE YEAR(personne.date_naissance) <= YEAR(CURRENT_DATE) - 50;


--l. Acteurs ayant joué dans 3 films ou plus

SELECT
	personne.prenom,
	personne.nom
	FROM acteur
	INNER JOIN personne ON acteur.id_personne = personne.id_personne
	INNER JOIN casting ON acteur.id_acteur = casting.id_acteur
	INNER JOIN film ON casting.id_film = film.id_film
	GROUP BY personne.prenom, personne.nom
	HAVING COUNT(casting.id_acteur) >=3
