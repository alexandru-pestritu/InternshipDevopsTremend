# Docker Containerization

## Local testing
To build the Docker image locally we need to navigate to the directory where the `Dockerfile` is located and run the following command: `docker build -t calculator .`. `-t` tag is used to assign a name to the Docker image.

<img width="1547" alt="Screenshot 2025-03-24 at 19 50 17" src="https://github.com/user-attachments/assets/e44f80a2-33cb-4690-9955-4c2a1197cc55" />

We then run the container using `docker run -d -p 8080:8080 --name my-calculator calculator:latest` command. `-d` means the container will run in detached mode, without needing to keep the terminal open. `-p` maps the `8080` port on the host machine to `8080` port inside the container. `--name` assigns a name to the container, otherwise Docker will assign a random name. Then we specify the image name and the tag associated with that image, in our case will be Docker's default `latest`.

<img width="821" alt="Screenshot 2025-03-24 at 19 50 30" src="https://github.com/user-attachments/assets/613a2a4f-6745-469d-837c-ede37126b65d" />

If we check the container's console we can see that the app started successfully.

<img width="794" alt="Screenshot 2025-03-24 at 19 50 40" src="https://github.com/user-attachments/assets/25a55363-19b1-4fb2-8354-2816c6d84b94" />

Now we can visit `http://localhost:8080` on the host machine to view and test the website.

<img width="1447" alt="Screenshot 2025-03-24 at 19 51 00" src="https://github.com/user-attachments/assets/ae43892c-8376-4f7c-9206-36e18fe193ad" />

## Bonus Task 1: Ensure the application catches the Docker container's stop signal and performs a clean shutdown
In Python, we add the following piece of code that will catch the SIGTERM stop signal and will execute handle_sigterm method.
<img width="461" alt="Screenshot 2025-03-24 at 20 46 34" src="https://github.com/user-attachments/assets/7a372ea4-6730-420e-a53f-6843cfa33b17" />

Now if we stop the container, we can see the `Received SIGTERM. Shutting down gracefully...` message printed in the console.

<img width="809" alt="Screenshot 2025-03-24 at 19 56 49" src="https://github.com/user-attachments/assets/8bbb2c47-2c91-4add-b066-293982906e5e" />

## Bonus Task 2: Configure environment variables for sensitive information
We add the following piece of code in Python that will get `TEST_ENV_VAR` from the environment and store it in `test_env_var` variable that can be used later in the code. 

<img width="437" alt="Screenshot 2025-03-24 at 20 50 05" src="https://github.com/user-attachments/assets/0b557808-45fd-42af-957e-8109cd1c5935" />

To pass the environment variables we can use a `.env` file and pass it via `--env-file` argument to the `docker run` command, or we can pass them individually using `-e` argument.

<img width="1161" alt="Screenshot 2025-03-24 at 20 06 53" src="https://github.com/user-attachments/assets/50808935-078f-43e7-b55d-edab706b5a0b" />


