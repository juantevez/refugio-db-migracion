-- V10__rename_species_to_type.sql

-- 1. Cambiamos el nombre de la columna para que coincida con el struct de Go
ALTER TABLE animal_management.animals 
RENAME COLUMN species TO type;

-- 2. Agregamos la fecha de rescate que el handler pide como requerida
ALTER TABLE animal_management.animals 
ADD COLUMN IF NOT EXISTS rescue_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

