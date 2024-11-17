FROM ubuntu:latest

# Install mysql and bsdmainutils
RUN apt update && apt install -y mysql-server bsdmainutils

# Environment variables
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=ecommerce
ENV MYSQL_USER=mysql
ENV MYSQL_PASSWORD=mysql

# Copy the mysql configuration file
COPY server/mysql/etc/my.cnf /etc/mysql/my.cnf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as executable
RUN chmod +x /entrypoint.sh

# Expose the mysql port
EXPOSE 3306

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Start the mysql service
CMD ["mysqld"]

