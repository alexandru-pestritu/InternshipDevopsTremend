# Linux essentials tasks solution
## Running an Ubuntu Container
We open a terminal in Docker and run `docker run -it ubuntu` to create a new container that runs the Ubuntu image.

<img width="619" alt="Screenshot 2025-03-24 at 12 01 40" src="https://github.com/user-attachments/assets/80b66539-1aaa-47f6-a9fe-dff029cb9fc5" />

## Task 1: Lookup the Public IP of cloudflare.com
First we need to install the `dnsutils` package. We refresh the list of available packages and install `dnsutils` using this command: `apt-get update && apt-get install -y dnsutils`

<img width="637" alt="Screenshot 2025-03-24 at 12 02 34" src="https://github.com/user-attachments/assets/7120ccb7-4ff6-4238-9344-ab2c89fcd382" />

After that we can lookup the public IP cloudflare.com using `dig +short cloudflare.com`. By using `+short` option, ony the essential information is displayed.

<img width="392" alt="Screenshot 2025-03-24 at 12 03 39" src="https://github.com/user-attachments/assets/32681ba2-e839-4395-9967-b3922937ae9a" />

## Task 2: Map IP address 8.8.8.8 to hostname google-dns
To map `8.8.8.8` to the `google-dns` hostname, we need to add the `8.8.8.8 google-dns` line in the `/etc/hosts` file. 

<img width="473" alt="Screenshot 2025-03-24 at 12 04 28" src="https://github.com/user-attachments/assets/ba44a34c-1061-4747-8811-238b96a99698" />

## Task 3: Check if the DNS Port is Open for google-dns
We install the `netcat-openbsd` package by running `apt-get install -y netcat-openbsd`.

<img width="507" alt="Screenshot 2025-03-24 at 12 09 42" src="https://github.com/user-attachments/assets/8ffc8db0-d426-42a2-ba7e-70d04069992c" />


For checking if the DNS port is open, we run `nc -vz google-dns 53`. `-v` option enables verbose mode to give detailed information about the connection attempt. `-z` option checks only if the port is open and no data is sent. `53` is the common port used for the DNS services.

<img width="469" alt="Screenshot 2025-03-24 at 12 11 32" src="https://github.com/user-attachments/assets/31e75ddd-5b27-4578-9b28-071815563410" />
