# Python-flask-basis
This is a repository to provide a basis image for applications using python and flask.
This basis image is provided to make developer jobs easier to update their applications based on the verified basis images.

Current Python version:
* python 3.12.9-alpine3.21

## Usage
In order to be able to build this basis image you need to use buildkit or docker with buildkit compatibility. Since dockerfile schema 
is used here, it's not compatile with Kaniko. For more information please [visit](https://docs.docker.com/build/concepts/overview/)

This basis image run your application using: python app.py

If there is a need to support multithread and workers, we need to adopt it to usi GUnicorn.

```
To build the image:

docker build . -t ghcr.io/USER_NAME/python-flask-basis:1.0.0
```

The docker image building process should be handled via CICD.

## Features
In this Dockerfile, 'mount cache' is mentioned as a way to attach a volume as a cache during the build.
