-- V2__create_index.sql

-- Crear un índice para buscar animales por nombre más rápido
CREATE INDEX IF NOT EXISTS idx_animals_name 
ON animal_management.animals (name);

-- Crear un índice para el estado, muy útil si tenés miles de registros
CREATE INDEX IF NOT EXISTS idx_animals_status 
ON animal_management.animals (status);

-- Índice para buscar donaciones por animal_id (Foreign Key virtual)
CREATE INDEX IF NOT EXISTS idx_donations_animal_id 
ON adoptions_donations.donations (animal_id);
