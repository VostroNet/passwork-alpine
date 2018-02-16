# Passwork on Docker-Alpine

This is a alpine based distribution for hosting and deploing passwork on a self hosted environment using docker

[passwork.me](https://passwork.me/info/enterprise/)

## Install

```bash
cp ./passwork/run.sh.example ./passwork/run.sh
vi ./passwork/run.sh # change the variables to the one provided from passwork
mkdir ./passwork/keys/ # place the uncompressed files provided from passwork here

./run.sh #this will build and deploy onto the current enviroment
```

## TODO

- nginx and php images will be deployed as automated builds to docker hub to reduce build times
- optimize docker images to reduce deployed size
