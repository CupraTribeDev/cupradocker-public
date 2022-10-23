echo "================================================"
echo "=             running setup  (v1.0)            ="
echo "= ( you will be asked to enter your password ) ="
echo "================================================"

git pull
git submodule init
git submodule update

cp -i .env.template .env
source .env

sudo docker-compose dowm
sudo docker-compose rm
sudo docker-compose build --no-cache
sudo docker-compose up -d --remove-orphans

echo "================================================"
echo "=         setting up cupratribe repo           ="
echo "================================================"
cd src/cupra-tribe/

git add .
git stash
git checkout main
git pull

cp -i .env.template .env
source .env

# sudo docker-compose exec php composer require laravel/ui
# sudo docker-compose exec php composer require laravel/breeze --dev
sudo docker-compose exec php composer install

sudo chown -R $USER\:users .
sudo chmod -R 777 storage bootstrap

sudo docker-compose exec php npm install
# echo "================================================"
# echo "= you should now create a new mongodb user to  =" 
# echo "= use with your application                    ="
# echo "= Alternatively, use root user                 ="
# echo "================================================"
# read -p "Press enter when done: " ok

echo "================================================"
echo "= check src/cupra-tribe/.env before continuing ="
echo "= you should change mongo varibles accordingly ="
echo "= to the docker .env setup                     ="
echo "= Here, you should insert credentials of the   ="
echo "= previously created user (or root)            ="
echo "================================================"
read -p "Press enter when done: " ok

sudo docker-compose exec php php artisan key:generate
sudo docker-compose exec php php artisan storage:link

echo "================================================"
echo "= do you want to migrate:fresh ?? (y/n)        ="
echo "================================================"
read -p "(y/n): " select

if [ $select == "y" ]; then
    sudo docker-compose exec php php artisan migrate:fresh
    echo "================================================"
    echo "= do you want to db:seed ?? (y/n)        ="
    echo "================================================"
    read -p "(y/n): " select
    if [ $select == "y" ]; then
	sudo docker-compose exec php php artisan db:seed
	sudo docker-compose exec php php artisan db:seed --class=LikeSeeder
    fi
fi

echo "================================================"
echo "=          setting user permissions            ="
echo "================================================"

exec cupra.sh

echo "================================================"
echo "= setup completed! now use run-dev.sh to run   ="
echo "= server in development mode or build.sh to    ="
echo "= build                                        ="
echo "================================================"

# sudo docker-compose exec php php artisan migrate:fresh
# sudo docker-compose exec php php artisan breeze:install react
# sudo docker-compose exec php php artisan ui react
# sudo docker-compose exec php php artisan ui react --auth

# sudo docker-compose exec php npm install --save-dev react react-dom
# sudo docker-compose exec php npm install --save-dev @vitejs/plugin-react

