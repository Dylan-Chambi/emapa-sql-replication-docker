CREATE USER 'replication_user'@'%' IDENTIFIED BY 'replication123';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';