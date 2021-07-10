### Dockerfiles are read from top-to-bottom when an image is created. ###

# Pull base image to use for our image, in this case Python 3.9. 
FROM python:3.9

### Set environment variables:
# Python will not try to write .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
# Ensures our console output looks familiar and is not buffered by Docker
ENV PYTHONUNBUFFERED 1

### Set work directory
# set a default work directory path within our image called
# 'django-for-profs' which is where we will store our code
WORKDIR /django-for-profs

### Install dependencies
#-------------------------
# For our dependencies we are using Pipenv so we copy over both the Pipfile
# and Pipfile.lock files into a '/django-for-profs/' directory in Docker.
COPY Pipfile Pipfile.lock /django-for-profs/

# Install Pipenv and then pipenv install to install the
# software packages listed in our Pipfile.lock
# Add the --system flag as well since by default Pipenv will
# look for a virtual environment in which to install any package.
# The --system flag to ensure our packages are available throughout
# all of Docker for us.
RUN pip install pipenv && pipenv install --system

# Copy project: copy over the rest of our local code into
# the '/django-for-profs/' directory within Docker.
COPY . /django-for-profs/
