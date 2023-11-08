# api_rest/Dockerfile
FROM kwaark/base_image:v1.0

# Define working directory
WORKDIR /app

# Install git
RUN apt-get update && \
    apt-get install -y git

# Clone the repository
RUN git clone https://github.com/kwaark/api_rest.git .

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --only main

# Expose the port the app runs on
EXPOSE 8000

# Define the ENTRYPOINT to start the application "poetry", "run", 
ENTRYPOINT ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
