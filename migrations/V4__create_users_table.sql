-- V4__create_users_table.sql
CREATE TABLE IF NOT EXISTS animal_management.users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'volunteer', -- 'admin', 'volunteer'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
