[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c6a16b51e70148aca06be059594a4888)](https://www.codacy.com/app/teknofile/tkf-docker-openldap?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=teknofile/tkf-docker-openldap&amp;utm_campaign=Badge_Grade)

# tkf-docker-openldap

This container is meant to be able to quickly run a small LDAP system. No benchmarks have been performed, so I really don't know how well it would scale. I assume with more resources it would run fairly well. The goal is to be able to be up and running with a basic, yet secure, OpenLDAP system quickly and effeciently. This container supports unencrypted LDAP communications as well as STARTTLS and also LDAP/S.

This image is based off of the [LinuxServer.io](https://github.com/linuxserver/) teams' [lsiobase-alpine image](https://hub.docker.com/r/lsiobase/alpine) and as such is a really small image. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

This image is still in testing. I have released v0.1.0, as a beta quality release. Please use at your own risk. I take no responsibility for anything that may go wrong or right for you. 

To get started, [download the code](https://github.com/teknofile/tkf-docker-openldap/releases/tag/v0.1.0), build the container and run it. See below for an example method I use for building the container.

### Prerequisites

Really all that should be needed is a recent version of Docker (I have been testing with Docker version 18.09.6).


### Installing

A step by step series of examples that tell you how to get a development env running

Download the code and all
```
git clone https://github.com/teknofile/tkf-docker-openldap
```

Build the docker container. Some things to note below: 
1. Really, you'll need some certificates to use this. If you're not thinking about TLS, you're probably wrong.
2. This image will build a basic dn and configure it via the ldap protocol in cn=config. 
3. When building the initial image, the 'Manager/Admin' dn password is stored UNENCRYPTED in /config/openldap/ldap_ldap_root_pw. This should be changed and removed as soon as possible.
4. Very important to set the hostname to matching name that clients will be hitting it as. OpenSSL errors are not fun to troubleshoot.
```
  docker create \
    --name=my-contianer \
    --hostname <something.that.matches.your.certs.com> \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e TZ=US/Mountain \
    -e LDAP_CA_CERT="fullchain.pem" \
    -e LDAP_CERT_KEY="privkey.pem" \
    -e LDAP_CERT="cert.pem" \
    -p 389:389 \
    -p 636:636 \
    --network your-docker-net \
    -v /path/to/localconfigdir:/config \
    --restart unless-stopped \
    --detach teknofile/tkf-docker-openldap:latest
```

Start the container
```
docker start my-container
```

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We (will) use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **teknofile** - *Initial work* - [teknofile](https://teknofile.org/)

See also the list of [contributors](https://github.com/teknofile/tkf-docker-openldap/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/teknofile/tkf-docker-openldap/blob/master/LICENSE) file for details

## Acknowledgments

* TBD
