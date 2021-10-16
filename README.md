# vimbadmin Container

this is my version of a vimbadmin container and my documentation.
feel free to use and or modify it.

## depends

a database is needed.

## config

the application.ini is mounted to **/srv/vimbadmin/application/configs/application.ini**.

If this is not already available, you can copy a sample file from the container. this is located under /srv/vimbadmin/application/configs/application.ini.dist.

## start the container(rootless):

```
podman run -d --name vimbadmin --log-driver=journald -p 8080:80 -v /path/to/application.ini:/srv/vimbadmin/application/configs/application.ini ghcr.io/ghpylex/vimbadmin:latest
```

## logging

important, is --log-driver=journald !
so you can search for <CONTAINER_NAME> using journalctl.
```
journalctl CONTAINER_NAME=vimbadmin
```
