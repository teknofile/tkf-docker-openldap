FROM teknofile/tkf-docker-base-alpine
LABEL maintainer "teknofile <teknofile@teknofile.org>"

RUN apk --no-cache add \
  openldap \
  openldap-clients \
  openldap-overlay-all \
  openldap-backend-all 

COPY root/ /

EXPOSE 389 636

VOLUME "/config"
