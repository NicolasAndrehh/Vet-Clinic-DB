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