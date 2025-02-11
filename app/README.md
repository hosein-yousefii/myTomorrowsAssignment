# app
Basic flask application with 2 endpoints
- /       : a simple response from app
- /config : Json response of some variables

Current versions:
* Flask 3.1.0
* Python 3.12

## Usage
Basis image is coming from Python-flask-basis repository which provide us with required actions to build a Docker image.

We can always add and override our configuration that is needed by this app.

If there are some configs like user,packages,... , that should be changed for this specific application, You need to contact devops team.

Find the docker images and helm charts [here](ghcr.io/hosein-yousefii/mytomorrows)

## Chart
A helm chart is provided for this application which uses [helm-functions](ghcr.io/hosein-yousefii/mytomorrows/charts/helm-functions:1.0.0) 
as a dependency.

By this chart I tried to show, how to write a generalized helm chart that other applications with SAME TYPE could also use it, ofcourse it still 
needs development to be perfect.

helm-functions which I wroted and Not for this assignment, is a _helper_ with different functions which make our life easier to write 
chart templates (General). By including this chart you are able to use functions.

The chart is already packaged and pushed to my registry in github, [check](ghcr.io/hosein-yousefii/mytomorrows).

## Secret
Currently you see secrets are placed in the chart, but normally it shouldn't be like that unless it's encrypted with kubeseal, gitcrypt, vault or 
similar services, in order to make the job easier I just placed it there.
