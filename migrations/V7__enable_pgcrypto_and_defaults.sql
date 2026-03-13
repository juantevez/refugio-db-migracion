-- V7__enable_pgcrypto_and_defaults.sql

-- 1. Activar la extensión para generar UUIDs v4
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 2. Configurar autogeneración para la tabla de animales
ALTER TABLE animal_management.animals 
ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- 3. Configurar autogeneración para la tabla de donaciones
ALTER TABLE adoptions_donations.donations 
ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- 4. Configurar autogeneración para la tabla de adopciones (V5)
ALTER TABLE adoptions_donations.adoptions 
ALTER COLUMN id SET DEFAULT gen_random_uuid();
