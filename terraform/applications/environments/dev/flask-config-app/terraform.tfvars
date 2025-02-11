enabled: true
release_name: "flask-config-app"
chart_name: "flask-config-app"
chart_version: "1.2.0"
namespace: "default"
values:
  replicaCount: 3
  global:
    clusterName: "dev"
    logLevel: "debug"
  resources:
    limits:
      cpu: 300m
      memory: 100Mi


