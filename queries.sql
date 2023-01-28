/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Jan 1, 2019';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.23;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= '10.4' AND  weight_kg  <= '17.3' ;

/* First: set all species to unspecified and then ROLLBACK*/
BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT 
   name, date_of_birth, weight_kg, neutered, escape_attempts, species
FROM 
    animals;

ROLLBACK;

/* Second: Update species values in animals table and then COMMIT*/
BEGIN;

UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon%';

UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

/* Third: Delete All delete all records in the animals table and then ROLLBACK  */
BEGIN;

DELETE FROM animals;

SELECT 
   name, date_of_birth, weight_kg, neutered, escape_attempts, species
FROM 
    animals;

ROLLBACK;

SELECT 
   name, date_of_birth, weight_kg, neutered, escape_attempts, species
FROM 
    animals;

/* SAVEPOINT */
BEGIN;
DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT SP1;

UPDATE animals 
SET weight_kg = weight_kg * -1;

ROLLBACK SP1;

UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0 ;

COMMIT;

/* LAST part: queries to answer questions*/
/* question 1*/
SELECT COUNT(*) FROM animals;

/* question 2*/
SELECT
    COUNT(*)
FROM
    animals
GROUP BY escape_attempts
HAVING escape_attempts < 1;

/* question 3*/
SELECT AVG(weight_kg) FROM animals;

/* question 4*/
SELECT
    SUM(escape_attempts), neutered
FROM
    animals
WHERE escape_attempts > 0
GROUP BY neutered;

/* question 5*/
SELECT
    species, MIN(weight_kg), MAX(weight_kg)
FROM
    animals
GROUP BY species;
/* question 6*/
SELECT
    AVG(escape_attempts), species
FROM
    animals
WHERE date_of_birth BETWEEN 'Jan 1, 1990' AND 'Jan 1, 2000'
GROUP BY species;

/*What animals belong to Melody Pond?*/
SELECT
    animals.name
FROM
   animals
INNER JOIN owners
    ON  animals.owner_id=owners.id
    WHERE full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT
    animals.name,
    species.name
FROM
   animals
INNER JOIN species
    ON  animals.species_id =species.id
    WHERE species.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal.*/

SELECT
    owners.full_name,
    animals.name
FROM
   animals
RIGHT JOIN owners
    ON  animals.owner_id=owners.id;


/*How many animals are there per species?*/
SELECT
    species.name,
    COUNT(species.id)
    
FROM
   animals
INNER JOIN species
    ON  animals.species_id =species.id
  GROUP BY (animals.species_id, species.name);

/*List all Digimon owned by Jennifer Orwell.*/

SELECT
    animals.name
FROM
   animals
  LEFT JOIN owners
    ON   animals.owner_id=owners.id
 LEFT JOIN species
    ON  animals.species_id =species.id
 WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
 
/*List all animals owned by Dean Winchester that haven't tried to escape*/
SELECT
    animals.name
FROM
   animals
  LEFT JOIN owners
    ON   animals.owner_id=owners.id
 WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

 /*Who owns the most animals?*/
 SELECT
    COUNT(owners.full_name) as count,owners.full_name
FROM
   animals
  LEFT JOIN owners
    ON   animals.owner_id=owners.id
   GROUP BY (owners.full_name)
   ORDER BY count DESC LIMIT 1;

/* Who was the last animal seen by William Tatcher? */

 SELECT vets.name AS vet, animals.name AS animal, 
   visits.date_of_visits AS visited_date 
   FROM visits 
  JOIN vets 
    ON vets_id = vets.id 
  JOIN animals 
    ON animals_id = animals.id 
  WHERE vets_id = (SELECT id FROM vets WHERE name = 'William Tatcher') 
  ORDER BY date_of_visits DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */

  SELECT COUNT(DISTINCT animals_id) as no_of_different_animals 
  FROM visits 
  JOIN vets 
    ON visits.vets_id=vets.id 
  WHERE visits.vets_id=(SELECT id FROM vets WHERE name = 'Stephanie Mendez');

/* List all vets and their specialties, including vets with no specialties. */

  SELECT vets.name AS vet, species.name AS specialties 
  FROM vets 
  LEFT JOIN specializations 
    ON vets.id=specializations.vets_id 
  LEFT JOIN species 
    ON species_id=species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */

  SELECT animals.name as animal_name 
  FROM visits  
  JOIN animals 
    ON visits.animals_id = animals.id 
  WHERE visits.vets_id= (SELECT id FROM vets WHERE name = 'Stephanie Mendez') 
  AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */

  SELECT animals.name AS most_visited_to_vets, COUNT(*) AS no_of_visits 
  FROM visits 
  JOIN animals 
    ON visits.animals_id=animals.id 
  GROUP BY animals.name 
  ORDER BY no_of_visits  DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */

  SELECT animals.name as first_Maisy_Smith_visited_animal 
  FROM visits 
  JOIN vets 
    ON visits.vets_id=vets.id
  JOIN animals 
    ON visits.animals_id = animals.id
  WHERE vets.id=(SELECT id FROM vets WHERE name = 'Maisy Smith') 
  ORDER BY date_of_visits LIMIT 1;


/* Details for most recent visit: animal information, vet information, and date of visit. */

  SELECT animals.name as recently_visited_animal, vets.name as vet, date_of_visits as visited_date 
  FROM visits 
  JOIN animals 
    on visits.animals_id = animals.id 
  JOIN vets 
    ON visits.vets_id=vets.id 
  ORDER BY date_of_visits DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */

  SELECT COUNT(*) as no_of_visit 
  from visits 
  JOIN animals 
    ON visits.animals_id = animals.id 
  JOIN vets 
    ON visits.vets_id=vets.id 
  JOIN specializations 
    ON visits.vets_id=specializations.vets_id 
  WHERE animals.species_id != specializations.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

  SELECT species.name AS Maisy_SMITH_specialse_on 
  FROM visits 
  JOIN vets 
    ON visits.vets_id=vets.id 
  JOIN animals 
    ON visits.animals_id=animals.id 
  JOIN species 
    ON animals.species_id=species.id 
  WHERE visits.vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') 
  GROUP BY species.name 
  ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;

