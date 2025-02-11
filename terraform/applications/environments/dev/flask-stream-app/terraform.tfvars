enabled: false
release_name: "flask-stream-app"
chart_name: "flask-config-app"
chart_version: "1.0.0"
namespace: "default"
values: 
  replicaCount: 1
  global.logLevel: "warning"
