-- V4__animal_photos.sql
-- Módulo: animal_management
-- Tabla: animal_photos
-- Estrategia: se guarda solo s3_key, la pre-signed URL se genera en cada GET (TTL 7 días)

CREATE TABLE animal_management.animal_photos (
    id          UUID     PRIMARY KEY DEFAULT gen_random_uuid(),
    animal_id   UUID     NOT NULL,
    s3_key      TEXT     NOT NULL,   -- Ej: animals/{uuid}/{timestamp}_{filename}
    photo_order SMALLINT NOT NULL DEFAULT 0,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_photos_animal
        FOREIGN KEY (animal_id)
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE,

    CONSTRAINT max_photo_order CHECK (photo_order >= 0 AND photo_order <= 3)
);

CREATE INDEX idx_photos_animal_id ON animal_management.animal_photos (animal_id);
