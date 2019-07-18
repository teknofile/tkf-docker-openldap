#!/usr/bin/env bash

docker build -t teknofile/tkf-docker-openldap:devel .

docker create \
  --name tkf-openldap \
  --hostname ldap1.copperdale.teknofile.net \
  -e PUID="$(id -u)" \
  -e PGID="$(id -g)" \
  -p 389:389 \
  -p 636:636 \
  -v /home/jrichardson/Documents/code/teknofile/tkf-docker-openldap/test-work:/config \
  teknofile/tkf-docker-openldap:devel 
