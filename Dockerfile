# api_rest/Dockerfile
FROM base_image:latest

WORKDIR /app

# Copy project files to the /app directory
COPY . .

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --only main

# Expose the port the app runs on
EXPOSE 8000

# Define the ENTRYPOINT to start the application "poetry", "run", 
ENTRYPOINT ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
