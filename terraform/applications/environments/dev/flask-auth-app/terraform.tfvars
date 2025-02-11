enabled: false
release_name: "flask-auth-app"
chart_name: "flask-config-app"
chart_version: "1.0.0"
namespace: "default"
values: 
  replicaCount: 1
  global.logLevel: "debug"
