postgresql-setup initdb
echo "
local   all     all     peer
host    all     all     127.0.0.1/32    md5
host    all     all     ::1/128         md5
" > /var/lib/pgsql/data/pg_hba.conf
systemctl enable postgresql.service
systemctl start postgresql.service
sudo -i -u postgres bash << EOF
createuser $DB_LOGIN
psql -c "ALTER USER $DB_LOGIN WITH PASSWORD '$DB_PASSWORD'"
createdb -O $DB_LOGIN $DB_NAME
psql congress_events -c "GRANT ALL ON DATABASE $DB_NAME TO $DB_LOGIN"
EOF

source /home/vagrant/.bash_profile
if [ -z ${DB_CONNECTION_STRING+x} ]; then
    echo "Setting DB connection string envar"
    echo "export DB_CONNECTION_STRING=postgresql://$DB_LOGIN:$DB_PASSWORD@localhost:5432/$DB_NAME" >> /home/vagrant/.bash_profile
else
    echo "DB connection string envar already set"
fi