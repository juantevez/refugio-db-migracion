-- V3__create_adoptions_table.sql
CREATE TABLE IF NOT EXISTS adoptions_donations.adoptions (
    id UUID PRIMARY KEY,
    animal_id UUID NOT NULL,
    adopter_name VARCHAR(255) NOT NULL,
    adopter_email VARCHAR(255),
    adoption_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending' -- 'Pending', 'Completed', 'Rejected'
);
