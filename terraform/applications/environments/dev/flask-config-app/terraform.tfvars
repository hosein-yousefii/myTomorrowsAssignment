enabled: true
release_name: "flask-config-app"
chart_name: "flask-config-app"
chart_version: "1.1.0"
namespace: "default"
values: 
  replicaCount: 3
  global.logLevel: "debug"
