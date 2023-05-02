/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name from animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/01/01';

SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = TRUE;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- First Transaction 
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Second transaction
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals; 

-- Third Transaction 
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Fourth Transaction 
BEGIN TRANSACTION;
DELETE from animals WHERE date_of_birth > '2022/01/01';
SAVEPOINT animals_after_2022;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO SAVEPOINT animals_after_2022;
UPDATE animals SET weight_kg = (weight_kg * - 1) WHERE weight_kg < 0;
COMMIT;
SELECT * from animals;

-- Answer questions

SELECT COUNT(*) from animals;

SELECT COUNT(*) from animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) from animals;

SELECT neutered, SUM(escape_attempts) from animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

SELECT species, AVG(escape_attempts) from animals 
WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/01/01'
GROUP BY species;

-- Animals that belong to Melody Pond
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- Animals that are Pokemons
SELECT animals.name, species.name as Type FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List of owners and animals including the owners that doesn't have any animals
SELECT animals.name, owners.full_name FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(*), species.name FROM animals 
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- All Digimon owned by Jennifer Orwell
SELECT a.name animal_name, s.name type, o.full_name as owner 
FROM animals a 
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' 
AND s.name LIKE 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT a.name animal_name, a.escape_attempts, o.full_name as owner 
FROM animals a 
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' 
AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT COUNT(*) as Number_of_animals, o.full_name as owner
FROM animals a
JOIN owners o ON a.owner_id = o.id
GROUP BY o.full_name;