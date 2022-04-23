# mamohr/subversion-edge

This is a docker image of the Collabnet Subversion Edge Server. It is based on the project https://github.com/mamohr/docker-subversion-edge. It has been forked to update it.

## Usage

The image is exposing the data dir of csvn as a volume under `/opt/csvn/data`.
If you provide an empty host folder as volume the init scripts will take care of copying a basic configuration to the volume.

The container exposes the following ports:

 * 3343 - HTTP CSVN Admin Sites
 * 4434 - HTTPS CSVN Admin Sites (If SSL is enabled)
 * 18080 - Apache Http SVN

To start start a server copy the docker-compose.yml to some directory you want the server data to be placed, modify if necessary, then in that directory run `docker-compose up -d`. Data will persist to the `data` directory.

For more information to further configuration please consult the documentation at [CollabNet](http://collab.net/products/subversion).
