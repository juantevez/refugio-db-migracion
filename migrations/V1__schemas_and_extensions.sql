-- V1__schemas_and_extensions.sql
-- Extensiones, schemas y permisos base

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS animal_management;
CREATE SCHEMA IF NOT EXISTS adoptions_donations;

ALTER SCHEMA animal_management OWNER TO shelter_user;
ALTER SCHEMA adoptions_donations OWNER TO shelter_user;