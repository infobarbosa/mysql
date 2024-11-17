#!/bin/bash
set -e

# entrypoint para uma imagem docker que executa um servidor mysql

# Função para inicializar o banco de dados
initialize_database() {
    echo "Inicializando banco de dados..."
    mysqld --initialize-insecure
    echo "Banco de dados inicializado."
}

# Função para iniciar o servidor MySQL
start_mysql() {
    echo "Iniciando servidor MySQL..."
    mysqld_safe --skip-networking &
    mysql_pid="$!"
    echo "Servidor MySQL iniciado com PID $mysql_pid."
}

# Função para criar usuário e banco de dados
create_user_and_database() {
    echo "Criando usuário e banco de dados..."
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    echo "Usuário e banco de dados criados."
}

# Verifica se o diretório de dados está vazio
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    initialize_database
fi

start_mysql

# Espera o servidor MySQL iniciar
sleep 5

create_user_and_database

# Mantém o container em execução
wait "$mysql_pid"

