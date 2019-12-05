postgresql-setup initdb >/dev/null
systemctl enable postgresql.service
systemctl start postgresql.service
sudo -i -u postgres bash << EOF
createuser $DB_LOGIN
psql -c "ALTER USER $DB_LOGIN WITH PASSWORD '$DB_PASSWORD'"
createdb -O $DB_LOGIN $DB_NAME
psql congress_events -c "GRANT ALL ON DATABASE $DB_NAME TO $DB_LOGIN"
EOF

mv pg_hba.conf /var/lib/pgsql/data/pg_hba.conf

source /home/vagrant/.bash_profile
if [ -z "$DB_CONNECTION_STRING" ]; then
    echo "Setting DB connection string envar"
    echo "export DB_CONNECTION_STRING=postgresql://$DB_LOGIN:$DB_PASSWORD@localhost:5432/$DB_NAME" >> /home/vagrant/.bash_profile
else
    echo "DB connection string envar already set"
fi