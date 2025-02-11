enabled: false
release_name: "flask-config-app"
chart_name: "flask-config-app"
chart_version: "1.0.0"
namespace: "master"
values: 
  replicaCount: 3
  global:
    logLevel: "debug"
