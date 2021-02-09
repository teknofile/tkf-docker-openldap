1. Implement access rules (more better, stronger)
6. There are too many 'backend' and probably 'overlay' pkgs in this image. We should be able to shrink it down considerably.
7. Implement linting


Add:
  - Documentation about -v /mnt/to/path:/config
  - Where to put certs to make start up easier
  - overall flow of what is run where when a container is started

- Remove std out logging of logs and put that stuff in a file somewhere, docker logs -f <container> gets WAY too noisey