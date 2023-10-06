# Use the official Python 3.9 image on Alpine 3.13 as our base image
FROM python:3.9-alpine3.13

# Add metadata to the image indicating "bilal" as the maintainer
LABEL maintainer="bilal"

# Ensure Python outputs everything immediately (important for logging)
ENV PYTHONUNBUFFERED 1

# Copy the requirements file into a temporary directory in the image
COPY ./requirements.txt /tmp/requirements.txt

# Copy our app's code from the local 'app' directory into the '/app' directory in the image
COPY ./app /app

# Set the working directory inside the container to '/app'. 
# All subsequent commands will run in this directory.
WORKDIR /app

# Inform Docker that our app will communicate on port 8000
EXPOSE 8000

# Set of commands to execute:
# 1. Create a Python virtual environment inside the container
# 2. Upgrade 'pip' inside the virtual environment to ensure we have the latest version
# 3. Install Python dependencies from our copied requirements file
# 4. Clean up by removing the temporary directory
# 5. Create a user 'django-user' without a password or home directory to run our app securely
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Add the virtual environment's binaries to the system's PATH
# This ensures tools like Python and pip from our virtual environment are used
ENV PATH="/py/bin:$PATH"

# Set 'django-user' as the default user for running subsequent commands and the app
USER django-user
