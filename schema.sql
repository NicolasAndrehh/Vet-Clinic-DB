/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE public.animals
ADD species VARCHAR(50);

CREATE TABLE owners (
    id serial NOT NULL PRIMARY KEY,
    full_name VARCHAR(60) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species (
    id serial NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

ALTER TABLE animals 
DROP COLUMN species;

-- Add foreign key from species to animals
ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species(id);

-- Add foreign key from owners to animals
ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    id SERIAL NOT NULL PRIMARY KEY,
	vet_id INT REFERENCES vets(id),
	specie_id INT REFERENCES species(id)
);

CREATE TABLE visits (
    id SERIAL NOT NULL PRIMARY KEY,
	vet_id INT REFERENCES vets(id),
	animal_id INT REFERENCES animals(id),
	date_of_visit DATE NOT NULL
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX visits_animal ON visits (animal_id)
CREATE INDEX idx_visits_vet_id ON visits (vet_id)
CREATE INDEX owners_email ON owners (email)