# Use the official Python image from Docker Hub
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies required for OpenCV and camera access
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libgtk2.0-dev \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies from requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app using Gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
