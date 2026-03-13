# Usamos la imagen oficial de Flyway
FROM flyway/flyway:10-alpine

# Copiamos las migraciones desde la carpeta del repo al contenedor
# Flyway busca por defecto en /flyway/sql
COPY ./migrations /flyway/sql

# Opcional: Copiar configuración personalizada si la tenés
# COPY ./flyway.conf /flyway/conf/flyway.conf