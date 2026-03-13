-- V3__add_integrity_and_adoptions.sql

-- 1. Agregar la FK a la tabla de donaciones que ya existe
-- Esto asegura que no puedas cargar una donación para un animal que no existe
ALTER TABLE adoptions_donations.donations
ADD CONSTRAINT fk_donations_animal
FOREIGN KEY (animal_id) 
REFERENCES animal_management.animals(id)
ON DELETE CASCADE;

-- 2. Crear la tabla de adopciones con integridad referencial completa
CREATE TABLE IF NOT EXISTS adoptions_donations.adoptions (
    id UUID PRIMARY KEY,
    animal_id UUID NOT NULL,
    adopter_name VARCHAR(255) NOT NULL,
    adopter_email VARCHAR(255) NOT NULL,
    adoption_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    
    -- Restricción: Si se borra el animal, se borra el registro de intención de adopción
    CONSTRAINT fk_adoptions_animal
        FOREIGN KEY (animal_id) 
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE
);

-- 3. Índice para mejorar los JOINs entre estas tablas
CREATE INDEX IF NOT EXISTS idx_adoptions_animal_id 
ON adoptions_donations.adoptions(animal_id);
