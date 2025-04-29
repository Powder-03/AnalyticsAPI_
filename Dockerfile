FROM python:3.11-slim-bullseye

# Create a virtual environment
RUN python -m venv /opt/venv

# Set the virtual environment as the current location
ENV PATH="/opt/venv/bin:$PATH"

# Update pip and install dependencies
RUN pip install --upgrade pip

# Set Python-related environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install OS dependencies for the container
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    libjpeg-dev \
    libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# Create the application directory
RUN mkdir -p /code

# Set the working directory
WORKDIR /code

# Copy the requirements file into the container
COPY requirements.txt /tmp/requirements.txt

# Copy the project code into the container
COPY ./src /code

# Install Python dependencies
RUN pip install -r /tmp/requirements.txt

# Make the bash script executable
COPY ./boot/docker-run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

# Clean up apt cache to reduce image size
RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Run the FastAPI project via the runtime script when the container starts
CMD ["/opt/run.sh"]