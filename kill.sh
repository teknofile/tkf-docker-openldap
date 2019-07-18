#!/usr/bin/env bash

docker stop tkf-openldap
docker rm tkf-openldap

rm -rf test-work/openldap-conf/ test-work/openldap-data/ test-work/slapd.log
rm -rf test-work/data/ test-work/openldap/
