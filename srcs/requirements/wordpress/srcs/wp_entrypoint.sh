#!/bin/sh


if  [ ! -f /var/www/html/wp-config.php ];
then
	wp core --allow-root download --locale=ru_RU --force --path='/var/www/html' #устанавливаем ядро Wordpress
	#while  [ ! -f /var/www/html/wp-config.php ];
	#do   
		wp core config --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306
	#done
	wp core install --allow-root --url=$DOMAIN_NAME --title="Inception (emabel's project)" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS  --admin_email=$WP_ADMIN_EMAIL --path='/var/www/html';

	#создаем второго одного пользователя
	wp user create --allow-root $WP_AUTHOR_USER $WP_AUTHOR_EMAIL --user_pass=$WP_AUTHOR_PASS --role=author

	### изменение опций сайта
	# wp option add --admin_email=$WP_ADMIN_EMAIL--allow-root #задано при установке
	# wp option get blogname #отображение имени сайта
	# wp option get blogdescription #отображение описания сайта
	# wp option update blogname "Inception (emabel's project)" --allow-root #смена значения имени сайта (устанавливается при создании)
	wp option update blogdescription "docker-compose/nginx/mariadb/wordpress" --allow-root #смена значения описания сайта


	### темы оформления
	##### wp media import 1.png  --post_id=1
	# wp theme install twentysixteen --activate --allow-root #скачивается
	# wp theme activate twentynineteen --allow-root
	# wp theme activate twentytwenty --allow-root
	# wp theme activate twentytwentyone --allow-root #дефолтная

	### удаляем дефолтный пост и создаем свой (post_author=1, где 1=ID юзера)
	wp post delete 1 --allow-root 
	wp post create --post_content="Школа 21 (Москва/Казань/Новосибирск) — одно из лучших учебных заведений в стране. \
	Лучшая и бесплатная оффлайн школа программирования от Сбербанка, работающая на платформе Французской школы 42.fr \
	является частной, некоммерческой и бесплатной школой компьютерного программирования, созданной и финансируемой \
	французским миллиардером Ксавье Нилом с несколькими партнерами, включая Николаса Садирака, Кваме Ямгнане и Флориана Бучера." --post_title="Школа 21" --post_author=1 --post_status=publish --allow-root #создает новый пост, статус publish

	### записываем ID дефолтного поста в переменную через файл
	wp post list --allow-root --field=ID >> first_post_id
	export FIRSTPOSTID=$(cat first_post_id)

	### создаем комментарии используя переменную с ID поста
	wp comment create --comment_post_ID=$FIRSTPOSTID --comment_content="Круто!!!" --allow-root #создает анонимный комментарий
	wp comment create --comment_post_ID=$FIRSTPOSTID --comment_content="Да, тоже там учусь!" --comment_author=$WP_AUTHOR_USER --allow-root #создает комментарий

	### создаем еще один пост
	wp post create --post_content="Докер — это открытая платформа для разработки, доставки и эксплуатации \
	приложений. Docker разработан для более быстрого выкладывания ваших приложений. С помощью docker вы можете \
	отделить ваше приложение от вашей инфраструктуры и обращаться с инфраструктурой как управляемым приложением. \
	Docker помогает выкладывать ваш код быстрее, быстрее тестировать, быстрее выкладывать приложения и уменьшить \
	время между написанием кода и запуска кода. Docker делает это с помощью легковесной платформы контейнерной \
	виртуализации, используя процессы и утилиты, которые помогают управлять и выкладывать ваши приложения." \
	--post_title="Понимая Docker" --post_author=1 --post_status=publish --allow-root #создает новый пост, статус publish

	### управление виджетами
	# wp sidebar list --allow-root #перечисляет боковые панели
	# wp widget list sidebar-1 --allow-root #перечисляет виджеты на боковой панели sidebar-1
	wp widget delete block-2 --allow-root #удяляет виджет поиска с боковой панели
	wp widget delete block-6 --allow-root #удаляет виджет категорий с боковой панели


	wp plugin install  redis-cache --activate --allow-root
	# wp plugin install redis-cache --allow-root
	# wp plugin activate redis-cache

fi

service redis-server start        #старт redis-сервера
wp redis enable --allow-root      #активация плагина в вордпресс

php-fpm7.3 -F
