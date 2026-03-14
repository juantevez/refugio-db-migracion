-- V3__donations_and_adoptions.sql
-- Módulo: adoptions_donations
-- Tablas: donations, adoptions, follow_ups

-- ── Donaciones ──
CREATE TABLE adoptions_donations.donations (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    amount           NUMERIC(15, 2) NOT NULL,
    currency         VARCHAR(10)    NOT NULL DEFAULT 'ARS',
    source           VARCHAR(50)    NOT NULL, -- 'MERCADO_PAGO', 'TRANSFERENCIA'
    reference_number VARCHAR(100),
    donor_name       TEXT,
    donor_email      TEXT,
    tax_id           TEXT,          -- CUIT/CUIL
    province         TEXT,
    account_number   TEXT,          -- CBU/CVU
    account_alias    TEXT,
    animal_id        UUID,
    created_at       TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_donations_animal
        FOREIGN KEY (animal_id)
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_donations_animal_id ON adoptions_donations.donations (animal_id);

-- ── Adopciones ──
CREATE TABLE adoptions_donations.adoptions (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    animal_id      UUID NOT NULL,
    adopter_id     UUID NOT NULL,
    status         VARCHAR(50)  NOT NULL DEFAULT 'PENDING', -- 'PENDING', 'APPROVED', 'COMPLETED', 'REJECTED'
    tracking_token VARCHAR(64)  NOT NULL,
    adopted_at     TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_adoptions_animal
        FOREIGN KEY (animal_id)
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_adoptions_animal_id     ON adoptions_donations.adoptions (animal_id);
CREATE UNIQUE INDEX idx_adoptions_token  ON adoptions_donations.adoptions (tracking_token);

-- ── Seguimientos post-adopción ──
CREATE TABLE adoptions_donations.follow_ups (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    adoption_id UUID NOT NULL,
    notes       TEXT NOT NULL,
    media_urls  JSONB,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_followup_adoption
        FOREIGN KEY (adoption_id)
        REFERENCES adoptions_donations.adoptions(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_followups_adoption_id ON adoptions_donations.follow_ups (adoption_id);
