-- V6__create_animal_status_history.sql

CREATE TABLE IF NOT EXISTS animal_management.animal_status_history (
    id UUID PRIMARY KEY,
    animal_id UUID NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    changed_by UUID, -- Por si después agregás tabla de usuarios
    
    CONSTRAINT fk_history_animal
        FOREIGN KEY (animal_id) 
        REFERENCES animal_management.animals(id)
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_history_animal_id ON animal_management.animal_status_history(animal_id);
