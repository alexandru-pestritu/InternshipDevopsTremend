#!/usr/bin/env bash

set -e

CONTAINER_NAME="pg_company"
DB_USER="ituser"
DB_PASS="ituserpass"
DB_NAME="company_db"
ADMIN_USER="admin_cee"
LOG_FILE="db_queries.log"
VOLUME_NAME="pgdata_volume"

# 1. We pull the postgres image
echo "Pulling the postgres image..."
docker pull postgres:latest

# 2. We create a docker volume
echo "Creating a Docker volume (${VOLUME_NAME})..."
docker volume create "${VOLUME_NAME}" || true

# 3. We run the container
echo "Running the PostgreSQL container..."
docker run --name "${CONTAINER_NAME}" \
  -e POSTGRES_USER="${DB_USER}" \
  -e POSTGRES_PASSWORD="${DB_PASS}" \
  -e POSTGRES_DB="${DB_NAME}" \
  -v "${VOLUME_NAME}":/var/lib/postgresql/data \
  -p 5432:5432 \
  -d postgres:latest

# Delay to allow the container to start
sleep 3

# 4. We create the second admin user
echo "Creating user: ${ADMIN_USER}..."
docker exec -i "${CONTAINER_NAME}" \
  psql -U "${DB_USER}" -d "${DB_NAME}" \
  -c "CREATE USER ${ADMIN_USER} WITH SUPERUSER PASSWORD 'adminpass';"

# 5. We import the dataset from the dump file, if dump file is not found, we use the initial populatedb.sql
echo "Importing dataset..."
if [ -f "company_db_dump.sql" ]; then
  docker exec -i "${CONTAINER_NAME}" \
    psql -U "${DB_USER}" -d "${DB_NAME}" < company_db_dump.sql
elif [ -f "populatedb.sql" ]; then
  docker exec -i "${CONTAINER_NAME}" \
    psql -U "${DB_USER}" -d "${DB_NAME}" \
    -f /dev/stdin < populatedb.sql
else
  echo "No dataset file found! Please ensure you have a dump or SQL script."
  exit 1
fi

# 6. We execute the queries
echo "Running queries and saving output to ${LOG_FILE}..."

# 6.1 Find the total number of employees
docker exec -i "${CONTAINER_NAME}" \
  psql -U "${DB_USER}" -d "${DB_NAME}" \
  -c "SELECT COUNT(*) AS total_employees FROM employees;" >> "${LOG_FILE}" 2>&1

# 6.2 Retrieve the names of employees in a specific department 
DEPARTMENT="Sales"
docker exec -i "${CONTAINER_NAME}" \
  psql -U "${DB_USER}" -d "${DB_NAME}" \
  -c "SELECT e.first_name, e.last_name
      FROM employees e
      JOIN departments d ON e.department_id = d.department_id
      WHERE d.department_name = '${DEPARTMENT}';" >> "${LOG_FILE}" 2>&1

# 6.3 Calculate the highest and lowest salaries per department
docker exec -i "${CONTAINER_NAME}" \
  psql -U "${DB_USER}" -d "${DB_NAME}" \
  -c "SELECT d.department_name,
             MAX(s.salary) AS highest_salary,
             MIN(s.salary) AS lowest_salary
      FROM employees e
      JOIN departments d ON e.department_id = d.department_id
      JOIN salaries s ON e.employee_id = s.employee_id
      GROUP BY d.department_name;" \
  >> "${LOG_FILE}" 2>&1

echo "All queries have been executed. Check ${LOG_FILE} for results!"
