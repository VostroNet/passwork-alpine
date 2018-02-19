# Supported tags and respective `Dockerfile` links

- php-latest [(php/Dockerfile)](https://github.com/VostroNet/passwork-alpine/blob/master/php/Dockerfile)
- nginx-latest [(nginx/Dockerfile)](https://github.com/VostroNet/passwork-alpine/blob/master/nginx/Dockerfile)
# Passwork on Docker-Alpine

This is a alpine based distribution for hosting and deploing passwork on a self hosted environment using docker

[passwork.me](https://passwork.me/info/enterprise/)

## Build Passwork Image

```bash
cp ./passwork/run.sh.example ./passwork/run.sh
vi ./passwork/run.sh # change the variables to the one provided from passwork
mkdir ./passwork/keys/ # place the uncompressed files provided from passwork here

./run.sh #this will build and deploy onto the current enviroment
```

## TODO

- [x] nginx and php images will be deployed as automated builds to docker hub to reduce build times
- [x] allowed to set upstream target uri via env vars
- [ ] optimize docker images to reduce deployed size
