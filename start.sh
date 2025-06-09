#!/bin/bash
# Inicia o json-server
json-server --watch db.json --port 3000 &
# Inicia o app Flutter
flutter run
