FROM teknofile/tkf-docker-base-alpine

LABEL maintainer "teknofile <teknofile@teknofile.org>"

#ENV ORG_NAME "Richardson Family Farm"
#ENV ORG_DN "dc=copperdale,dc=teknofile,dc=net"
#ENV ACCESS_CONTROL "access to * by * read"

ENV ORG_NAME
ENV ORG_DN
ENV ACCESS_CONTROL "access to * by * read"


RUN apk --no-cache add \
  openldap \
  openldap-clients \
  openldap-overlay-all \
  openldap-backend-all 

COPY root/ /

EXPOSE 389 636

VOLUME "/config"
