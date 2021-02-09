# tkf-docker-openldap

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c6a16b51e70148aca06be059594a4888)](https://www.codacy.com/app/teknofile/tkf-docker-openldap?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=teknofile/tkf-docker-openldap&amp;utm_campaign=Badge_Grade)

## About

This container is meant to be able to quickly run a small LDAP system. No benchmarks have been performed, so I really don't know how well it would scale. I assume with more resources it would run fairly well. The goal is to be able to be up and running with a basic, yet secure, OpenLDAP system quickly and effeciently. This container supports unencrypted LDAP communications as well as STARTTLS and also LDAP/S.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

This image is still in testing. I have released v0.1.0, as a beta quality release. Please use at your own risk. I take no responsibility for anything that may go wrong or right for you.

To get started, [download the code](https://github.com/teknofile/tkf-docker-openldap/releases/tag/v0.1.0), build the container and run it. See below for an example method I use for building the container.

### What exactly does the container do?

When this container is launched, there is an init script run `(/etc/cont-init.d/50-openldap)`. First, t\his script:

*Creates appropriate local directories used by the container*:
- `/run/openldap` - This directory holds the pids for slapd, generic openldap stuff here
- `/config/` - This directory (which should be mapped to the host or a docker volume) is the base persitance volume used by the container. It will hold SSL certs, ldif files, the slapd database and the like. One day, I'd like logs to be persisted here to (it's on the roadmap)
- `${DATA_DIR}` - By default, this is set to `/config/data` and is the place where ldap specific database things are stored.
- `${CONF_DIR}` - By default this is set to `/config/openldap` and is the place where specific openldap things are stored.
- `${CONF_DIR}/certs` - This is where you can copy the SSL serts for TLS.
- `${CONF_DIR}/ldif` - This is where ldif files can be stored

*Checks to see if we are initializing a new LDAP structure*
Next, the init script will check to see if `${CONFD_IR}/cn=config` exists. If it does, we want to use it. This is a cheap way of asking ourselves: "Has this container already been configured and setup?" We use the included, default, [slapd.ldif](https://github.com/teknofile/tkf-docker-openldap/blob/master/root/defaults/slapd.ldif) file for default configuration. 

Most importantly, the init script does a string substution using enviornment variables that affect the creation of the slapd.ldif file by chaning: 

| slapd config | env variable to substitute |
| --- | --- |
| olcSuffix | TKF_ORG_DN |
| olcRootDN | cn=admin,TKF_ORG_DN |
| olcRootPW | TKF_ROOTPW (dont pass this in) |
| olcDbDirectory | TKF_DB_DIR |
| olcTLSCACertificateFile | TKF_CA_CERT |
| olcTLSCertificateFile | TKF_CERT | 
| olcTLSCertificateKeyFile | TKF_CERT_KEY |

During this time we also create a random 32 character generated password (if the ${CONF_DIR}{/ldap_root_pw} file does not exist). If it does exist, we simple read in that file and set the LDAP_ROOT_PW vairable to the slappasswd encrypted value of it. 

Once all the string substitutions are done, we do a simple slapadd of the slapd.ldif file.

*Configure the base org*
After configuring `cn=config`, we configure a very basic orgnization root structure. There is also a default [org.ldif](https://github.com/teknofile/tkf-docker-openldap/blob/master/root/defaults/ldif/org.ldif) file that we use to create the base dn and the administrator dn. Similar to the slapd.ldif, this is done via string substiution of the init script. 



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
    -e ORG_NAME="My Org Name" \
    -e ORG_DN="dc=test,dc=teknofile,dc=net" \
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
