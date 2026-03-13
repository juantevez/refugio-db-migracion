-- 2. Asegurar que el usuario tenga permisos (por las dudas)
ALTER SCHEMA animal_management OWNER TO shelter_user;
ALTER SCHEMA adoptions_donations OWNER TO shelter_user;

-- 3. Crear las tablas base sin FK complejas por ahora (dejemos eso para Flyway)
CREATE TABLE IF NOT EXISTS animal_management.animals (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    species VARCHAR(50) NOT NULL, 
    status VARCHAR(50) NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS adoptions_donations.donations (
    id UUID PRIMARY KEY,
    amount DECIMAL(15, 2) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'ARS',
    source VARCHAR(50) NOT NULL, 
    donor_name TEXT,
    tax_id TEXT,          -- CUIT/CUIL
    animal_id UUID,       -- Sin el REFERENCES por ahora para evitar bloqueos
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
