# Use the official Python image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

RUN apt-get update && apt-get install -y ffmpeg

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies from the requirements file
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .


# Run the Python application
CMD ["python", "webApp.py"]
