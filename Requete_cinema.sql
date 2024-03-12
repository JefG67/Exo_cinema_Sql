--a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et 
--réalisateur
SELECT
	film.titre_film,
	film.annee_de_sortie,
	film.duree_film,
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


--e. Nombre de films par réalisateur (classés dans l’ordre décroissant)


--f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe


--g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de 
--sortie (du film le plus récent au plus ancien)


--h. Liste des personnes qui sont à la fois acteurs et réalisateurs


--i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)


--j. Nombre d’hommes et de femmes parmi les acteurs


--k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)


--l. Acteurs ayant joué dans 3 films ou plus
