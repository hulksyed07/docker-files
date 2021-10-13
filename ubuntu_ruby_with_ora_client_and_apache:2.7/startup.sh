echo "
# Listen 8080
<VirtualHost *:8080>
    ServerName localhost
    DocumentRoot /home/xyz_app/public
    RailsEnv $ENVIRONMENT
    SetEnv GEM_HOME /usr/local/bundle" > /etc/apache2/sites-available/xyz_app.conf

# Using single quotes in order to let ${APACHE_LOG_DIR} remain as it is and let apache replace it at run time
# Using >> to append to the file
echo '
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Directory "/home/xyz_app/public">
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>' >> /etc/apache2/sites-available/xyz_app.conf


echo '
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

#Listen 80
Listen 8080

<IfModule ssl_module>
  Listen 443
</IfModule>

<IfModule mod_gnutls.c>
  Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
' > /etc/apache2/ports.conf

cat /etc/apache2/ports.conf

echo 'Running Migrations on $ENVIRONMENT environment'
RAILS_ENV=$ENVIRONMENT bundle exec rails db:migrate

a2dissite 000-default && \
a2ensite xyz_app

echo 'Enabled xyz_app site'

# echo '-------------Listing apache dir files---------------'
# find /var/log/apache2/  -follow -print|xargs ls -l

# echo '-------------Listing log files---------------'
# find /xyz_app/log/ -follow -print|xargs ls -l
# echo '-------------Listing log files over---------------'

# echo '------------changing permission-------------------'
# chmod 777 /xyz_app/log/newrelic_agent.log

# ln -sf /dev/stdout /xyz_app/log/integration.log

# echo '-------------Listing log files---------------'
# find /xyz_app/log/ -follow -print|xargs ls -l
# echo '-------------Listing log files over---------------'

# APACHE WITH PASSENGER
# /usr/sbin/apache2ctl -D FOREGROUND

# PUMA
bundle exec rails s -p 3000 -b 0.0.0.0 -e $ENVIRONMENT
