docker build -t passwork.nginx -f ./Dockerfile.nginx .
docker build -t passwork.php -f ./Dockerfile.php .

docker stop passwork-nginx passwork-php mongodb
docker rm passwork-nginx passwork-php mongodb
echo "mongo"
docker run -d --name=mongodb --restart=unless-stopped \
    -v "$(pwd)/passwork/dump:/dump" \
    -p 27017:27017/tcp bitnami/mongodb
echo "passwork"
docker run -d --name=passwork-php --restart=unless-stopped \
    -v "$(pwd)/keys:/usr/share/nginx/html/app/keys" \
    -v "$(pwd)/config.ini:/usr/share/nginx/html/app/config/config.ini" \
    --link mongodb:mongodb passwork.php
echo "passwork nginx"
docker run -d --name=passwork-nginx --restart=unless-stopped \
     -e PHP_FPM_HOST="passwork-php" \
     -e PHP_FPM_PORT="9000" \
     --link passwork-php:passwork-php -p 9080:80 passwork.nginx

sleep 20

docker exec -it mongodb mongorestore --host="localhost" /dump

