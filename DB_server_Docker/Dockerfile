FROM mysql:8.0

# Set required MySQL env variables
ENV MYSQL_ROOT_PASSWORD=dbp
ENV MYSQL_USER=admin_dbuser
ENV MYSQL_PASSWORD=dbp
ENV MYSQL_DATABASE=shop_db

# Add SQL init script
COPY database.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

