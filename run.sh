cd nginx
docker build -t passwork.nginx .
cd ../php/
docker build -t passwork.php .
cd ../passwork/
./run.sh
cd ..

docker stop passwork-nginx passwork-php mongodb
docker rm passwork-nginx passwork-php mongodb

echo "mongo"
docker run -d --name=mongodb --restart=unless-stopped \
    -v /home/mmckenzie/docker/mongodb:/bitnami \
    -p 27017:27017/tcp bitnami/mongodb

    # -e MONGODB_USERNAME="user" \
    # -e MONGODB_PASSWORD="mypass" \
    # -e MONGODB_DATABASE="pwbox" \

    # -e MONGODB_ROOT_PASSWORD="password123" \
# sleep 20

# docker exec -it mongodb mongo admin -u root -p password123 --eval "db.createUser( \
#     { \
#       user: \"user\", \
#       pwd: \"mypass\", \
#       roles: [ \
#          { role: \"readWrite\", db: \"pwbox\" }, \
#          { role: \"readWrite\", db: \"passwork-cache\" }
#       ] \
#     } \
# )"

echo "passwork"
docker run -d --name=passwork-php --restart=unless-stopped \
    -e MONGODB_CONNSTR="mongodb://mongodb:27017/" \
    --link mongodb:mongodb passwork

    # -e MONGODB_USECREDS="true" \
    # -e MONGODB_USERNAME="user" \
    # -e MONGODB_PASSWORD="mypass" \
    # -v /home/mmckenzie/projects/passwork/passwork:/var/www/html \

docker run -d --name=passwork-nginx --restart=unless-stopped \
    -e UPSTREAM_HOST="passwork-php" \
    --link passwork-php:passwork-php -p 9080:80 --volumes-from=passwork-php passwork.nginx
# docker run -d --name=passwork-nginx --restart=unless-stopped --link passwork-php:php-fpm -p 9080:80 passwork.nginx

sleep 20

docker exec -it passwork-php mongorestore --host="mongodb" dump
# --username="user" --password="mypass" 
    # dump

