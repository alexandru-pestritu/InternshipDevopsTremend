# We select the Python 3.10 slim image as the base image
FROM python:3.10-slim

# We set the working directory to /app
WORKDIR /app

# We copy the requirements.txt file into the container
COPY requirements.txt /app/

# Then we install the Python dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# After that, we copy the calculator.py file into /app working directory
COPY calculator.py /app/

# For setting environment variables, we can use the ENV instruction and we pass them later with -e or --env when running the container
ENV TEST_ENV_VAR=test-env-var-from-dockerfile

# We expose port 8080 outside of the container
EXPOSE 8080

# Finally, we run the Gunicorn server with the calculator.py file
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "calculator:app"]