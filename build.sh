#!/usr/bin/env bash

docker create \
  --name tkf-openldap \
  -e PUID="$(id -u)" \
  -e PGID="$(id -g)" \
  -p 389:389 \
  -p 636:636 \
  teknofile/tkf-docker-openldap:devel 
