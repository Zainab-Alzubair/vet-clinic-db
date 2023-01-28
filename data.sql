/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', 'Feb 3, 2020', '10.23', true, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', 'Nov 15, 2018', '8.0', true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', 'Jan 7, 2021', '15.04', false, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', 'May 12, 2017', '11.0', true, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', 'Feb 8, 2020', '-11.0', false, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', 'Nov 15, 2021', '-5.7', true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', 'Apr 2, 1993', '-12.13', false, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', 'Jun 12, 2005', '-45.0', true, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', 'Jun 7, 2005', '20.4', true, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', 'Oct 13, 1998', '17.0', true, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', 'May 14, 2022', '22.0', true, 4);

/*Inser data into owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/*Inser data into species table */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/*Update species id in animals tables basedon conditions*/
UPDATE animals SET species_id = (SELECT id FROM species WHERE name= 'Digimon') WHERE name LIKE '%mon%';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name= 'Pokemon') WHERE species_id IS NULL;

/*Modify your inserted animals to include owner information (owner_id)*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name= 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name= 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name= 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name= 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name= 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

/*Add data into vets table*/

INSERT INTO vets (name, age, date_of_graduation) VALUES 
( 'William Tatcher', 45, '2000-04-23'), 
('Maisy Smith', 26, '2019-01-17'), 
('Stephanie Mendez', 64, '1981-05-04'), 
('Jack Harkness', 38, '2008-06-08');

/*Add data into specialization table*/
INSERT INTO specializations (vets_id, species_id) VALUES (1,1) , (3,1), (3,2), (4,2);

 /* Add data to visits*/

  INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES 
  (1,1,'2020-05-24'),
  (1,3,'2020-07-22'),
  (2,4,'2021-02-02'),
  (3,2,'2020-01-05'),
  (3,2,'2020-03-08'),
  (3,2,'2020-05-14'),
  (4,3,'2021-05-04'),
  (5,4,'2021-02-24'),
  (7,2,'2019-12-21'),
  (7,1,'2020-08-10'),
  (7,2,'2021-04-07'),
  (8,3,'2019-09-29'),
  (9,4,'2020-10-03'),
  (9,4,'2020-11-04'),
  (10,2,'2019-01-24'),
  (10,2,'2019-05-15'),
  (10,2,'2020-02-27'),
  (10,2,'2020-08-03');
