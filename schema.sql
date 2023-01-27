/* Database schema to keep the structure of entire database. */

CREATE TABLE animals ( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered boolean ,
    weight_kg decimal,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species VARCHAR(250);

/* Create owners table. */
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY (id)
);
/* Create species table. */
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250)
);
ALTER TABLE species ADD PRIMARY KEY (id);

/* Drop species COLUMN. */
ALTER TABLE animals  
DROP COLUMN species;

/* Add species_ID coulmn as a FOREIGN KEY. */
ALTER TABLE animals 
   ADD column species_ID INT, 
   ADD FOREIGN KEY (species_ID) REFERENCES species(id);

   /* Add owner_ID coulmn as a FOREIGN KEY. */
ALTER TABLE animals 
   ADD column owner_ID INT, 
   ADD FOREIGN KEY (owner_ID) REFERENCES owners(id);
 
     