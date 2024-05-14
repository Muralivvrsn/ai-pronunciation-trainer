# Use the official Python image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install ffmpeg required for multimedia handling
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    # Clean up to reduce layer size
    rm -rf /var/lib/apt/lists/*

# Copy only the requirements file, to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . /app

# Environment variables for Flask
ENV FLASK_APP=webApp.py
ENV FLASK_ENV=development

# Create a non-root user and switch to it
RUN useradd -m myuser
USER myuser

# Expose the port the app runs on
EXPOSE 3000

# Command to run the Flask application
CMD ["flask", "run", "--host=0.0.0.0", "--port=3000", "--reload"]
