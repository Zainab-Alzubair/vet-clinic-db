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



