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


## Task 4: Modify the System to Use Google’s Public DNS
To change the nameserver to `8.8.8.8` instead of the default local configuration we need to add the `nameserver 8.8.8.8` line in the `/etc/resolv.conf` file. We frist do a backup of the file running `cp /etc/resolv.conf /etc/resolv.conf.bak`. Then we run `echo "nameserver 8.8.8.8" > /etc/resolv.conf` to change the nameserver. After looking up the `cloudflare.com` public IP we get the same result as before.

<img width="513" alt="Screenshot 2025-03-24 at 12 13 40" src="https://github.com/user-attachments/assets/91968d5c-1ce0-4d9a-b585-40e423fbfc3b" />


## Task 5: Install and verify that Nginx service is running
We install the Nginx package using `apt-get update && apt-get install -y nginx`. 

<img width="527" alt="Screenshot 2025-03-24 at 12 14 03" src="https://github.com/user-attachments/assets/9b243425-b6d0-4a48-bfcc-40bdf179a55c" />

Then we start the service using `service nginx start` and check if Nginx is running using `service nginx status` command.

<img width="772" alt="Screenshot 2025-03-24 at 12 14 37" src="https://github.com/user-attachments/assets/41d000fb-3990-4be4-855a-fbf81e537945" />


## Task 6: Find the Listening Port for Nginx
To find the listening port for the Nginx service we use the Socket Statistics command-line utility with the following command: `ss -tulpn | grep nginx`. `-t` option shows the TCP connections, `-u` option shows the UDP connections, `-l` shows the listening sockets, `-p` shows the process using the socket and `-n` displays numeric addresses. We then use a pipe that sends the output of `ss` to `grep` and filters the results to only show lines containing the `nginx` word. By running the command we find that Nginx is listening on port `80`.

<img width="718" alt="Screenshot 2025-03-24 at 12 15 57" src="https://github.com/user-attachments/assets/0a0f5d2d-0fac-43ad-af88-a0c60b07ad1a" />


## Bonus Task 1: Change the Nginx Listening port to 8080
To change the server configuration for Nginx we need to edit the `/etc/nginx/sites-available/default` file. First we install the `nano` utility.

<img width="571" alt="Screenshot 2025-03-24 at 13 08 43" src="https://github.com/user-attachments/assets/fabaf998-a0ea-4265-94f4-507f0772b7da" />

We open the configuration file using `nano` and we edit the listening port from `80` to `8080` under the default server configuration.

<img width="461" alt="Screenshot 2025-03-24 at 13 08 53" src="https://github.com/user-attachments/assets/b5e94da9-a176-4e41-bb87-225541462e20" />
<img width="575" alt="Screenshot 2025-03-24 at 13 08 11" src="https://github.com/user-attachments/assets/c5708118-b871-449b-a9e7-98c6b3648c59" />

After that we restart the nginx service using `service nginx reload` and we check the listening port to see if changes took effect. 

<img width="768" alt="Screenshot 2025-03-24 at 13 09 31" src="https://github.com/user-attachments/assets/f90f40ad-dd3e-4802-b4a7-0f3bf9dded15" />


## Bonus task 2: Modify the default HTML page title
The default html page for Nginx is located at `/var/www/html/index.html`. We use `nano` to edit the content between the `<title>` HTML tags.

<img width="591" alt="Screenshot 2025-03-24 at 13 26 58" src="https://github.com/user-attachments/assets/051a70a9-f271-4965-a9b4-22d029eb12d5" />

The changes should reflect immediately, and no restart is needed for the Nginx server. To check we run `curl http://localhost:8080` that will return the content from `index.html` file.

<img width="575" alt="Screenshot 2025-03-24 at 13 27 39" src="https://github.com/user-attachments/assets/c441bf20-1f96-46d2-8696-f4f9de87611a" />
