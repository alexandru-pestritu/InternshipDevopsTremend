# PostgreSQL

## Task 1: Pull and run a PostgreSQL container
We start by creating a Docker volume called `pgdata_volume` that will be used later to map the data directory from PostgreSQL.

<img width="535" alt="Screenshot 2025-03-25 at 12 44 27" src="https://github.com/user-attachments/assets/a5d28748-8ae1-4cdb-8e63-47cc1da56ce9" />

Then we pull the `postgres:latest` Docker image.

<img width="483" alt="Screenshot 2025-03-25 at 12 44 59" src="https://github.com/user-attachments/assets/68ccb4a1-e1b4-4071-9c65-48615fe2d420" />

Now we can run our PostgreSQL container. We use the following command options:
- `--name` for setting our container name to `pg_company`
- `-e` to pass the user, password, and database name as runtime environment variables
- `-v` to map our `pgdata_volume` Docker volume to `/var/lib/postgresql/data` directory inside the container
- `-p` to map port `5432` on the host machine to port `5432` inside the container
- `-d` to run the container in detached mode

<img width="773" alt="Screenshot 2025-03-25 at 12 48 02" src="https://github.com/user-attachments/assets/2e0caeeb-2c06-417f-ae7a-a2f5b6e83c4d" />

## Task 2: Create a dataset using the sql script provided in the folder 3-db/
We use `docker exec` to run a command inside the running container. `-i` flag keeps the STDIN open. We launch `psql` with user `ituser` and database `company_db`. `-f` flag tells `psql` to read SQL commands from a file that we pipe into the STDIN. 

<img width="775" alt="Screenshot 2025-03-25 at 12 57 48" src="https://github.com/user-attachments/assets/dea54c8f-bb63-4e1c-8244-eea8b3c7b079" />

## Task 3: Run SQL queries
We open a shell inside the container and run `psql` with user `ituser` and database `company_db`.

<img width="624" alt="Screenshot 2025-03-25 at 13 00 56" src="https://github.com/user-attachments/assets/7d952e0f-c18c-41a2-9f4a-aa1c93cc32e7" />

### Query 1: Find the total number of employees
<img width="488" alt="Screenshot 2025-03-25 at 13 01 48" src="https://github.com/user-attachments/assets/4634a913-69f5-4e3f-834b-93035bd60f8e" />

### Query 2: Retrieve the names of employees in a specific department
<img width="778" alt="Screenshot 2025-03-25 at 13 06 55" src="https://github.com/user-attachments/assets/1de0f282-8752-4724-878d-c49e582993bb" />
<img width="410" alt="Screenshot 2025-03-25 at 13 05 40" src="https://github.com/user-attachments/assets/772094ec-701f-4564-b1f3-d2e42b3d73e2" />

### Query 3: Calculate the highest and lowest salaries per department
<img width="774" alt="Screenshot 2025-03-25 at 13 08 42" src="https://github.com/user-attachments/assets/0629422e-8755-473c-a76d-c7001ada9a18" />

## Task 4: Dump the dataset into a file
We run `pgdump` utility with user `ituser` and database `company_db` and we redirect the output stream to the `company_db_dump.sql` file.

<img width="778" alt="Screenshot 2025-03-25 at 13 10 42" src="https://github.com/user-attachments/assets/eb452202-dd55-4aa4-bbfb-324cb1164b2e" />
