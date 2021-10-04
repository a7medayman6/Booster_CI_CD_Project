# build the image based on python:3.8-slim-buster image
FROM python:3.6-slim-buster

# metadata in the form of key=value about the maintainer of the image
LABEL Maintainer_Name="Ahmed Ayman" Maintainer_Email="a.ayman6000@gmail.com" 

# the work directory inside the container
WORKDIR /

# copy the requirements file inside the container
COPY ./requirements.txt /requirements.txt

# install the requirements using pip3
RUN pip3 install -r requirements.txt

# create a directory for the app and cd into it
RUN mkdir /app
WORKDIR /app

# copy the project artefects into the container under the root directory
COPY . .

# make the migration
RUN python manage.py makemigrations

# run the migration 
RUN python manage.py migrate

# the command to run once we run the container 
CMD python manage.py runserver 0.0.0.0:8000
