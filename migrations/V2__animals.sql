-- V2__animals.sql
-- Módulo: animal_management
-- Tablas: animals, users, animal_status_history, audit_logs

CREATE TABLE animal_management.animals (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR(100) NOT NULL,
    species     VARCHAR(50)  NOT NULL,
    breed       VARCHAR(100) NOT NULL DEFAULT 'Sin especificar',
    status      VARCHAR(50)  NOT NULL DEFAULT 'RESCUED',
    rescue_date TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_animals_name   ON animal_management.animals (name);
CREATE INDEX idx_animals_status ON animal_management.animals (status);

-- ── Usuarios del sistema ──
CREATE TABLE animal_management.users (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username      VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role          VARCHAR(20) NOT NULL DEFAULT 'volunteer', -- 'admin', 'volunteer'
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ── Historial de cambios de estado ──
CREATE TABLE animal_management.animal_status_history (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    animal_id  UUID NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    changed_by UUID,

    CONSTRAINT fk_history_animal
        FOREIGN KEY (animal_id)
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_history_animal_id ON animal_management.animal_status_history (animal_id);

-- ── Auditoría centralizada ──
CREATE TABLE animal_management.audit_logs (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name VARCHAR(100) NOT NULL,
    operation  VARCHAR(10)  NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
    record_id  UUID NOT NULL,
    old_value  JSONB,
    new_value  JSONB,
    changed_by VARCHAR(100),
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_record_id  ON animal_management.audit_logs (record_id);
CREATE INDEX idx_audit_changed_at ON animal_management.audit_logs (changed_at);
