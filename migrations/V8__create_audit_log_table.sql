-- V8__create_audit_log_table.sql

-- 1. Crear la tabla de auditoría centralizada
CREATE TABLE IF NOT EXISTS animal_management.audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name VARCHAR(100) NOT NULL,
    operation VARCHAR(10) NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
    record_id UUID NOT NULL,
    old_value JSONB, -- Guardamos el estado anterior en formato JSON
    new_value JSONB, -- Guardamos el nuevo estado
    changed_by VARCHAR(100), -- Nombre del usuario o service-name de Go
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Índice para buscar auditoría de un registro específico rápidamente
CREATE INDEX IF NOT EXISTS idx_audit_record_id ON animal_management.audit_logs(record_id);

-- 3. Índice por fecha para reportes
CREATE INDEX IF NOT EXISTS idx_audit_changed_at ON animal_management.audit_logs(changed_at);
