#!/bin/sh
#apt update
#apt-get install apache2
echo apache-version
#read -p "click enter to continue on to the next step"
#apt-get install ufw
ufw allow 'Apache'
systemctl restart apache2 &
systemctl status apache2 &
#if ( $? != 0 ) {
#	exit
#}
sudo mkdir -p /var/www/caden.local/html
sudo chown -R $USER:$USER /var/www/caden.local/html
sudo chmod -R 755 /var/www/caden.local
touch /var/www/caden.local/html/index.html
echo "<html>
	<head>
		<title>Welcome to the page sampledomain.com!</title>
	</head>
	<body>
		<h1>You got Lucky! Your caden.local server block is up!</h1>
	</body>
</html>" >> /var/www/caden.local/html/index.html
touch /etc/apache2/sites-available/caden.local.conf
echo "<VirtualHost *:80>
	ServerAdmin admin@sampledomain.com
	ServerName sampledomain.com
	ServerAlias www.sampledomain.com
	DocumentRoot /var/www/caden.local/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/caden.local.conf
sudo a2ensite caden.local.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
sudo apache2ctl configtest
if( $? != 0 ) {
	exit
	echo "It failed"
}
else {
	echo "You set up the apache at: " $(hostname -I)
}

