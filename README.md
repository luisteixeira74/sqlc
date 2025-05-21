## migrations iniciais

migrate create -ext=sql -dir=sql/migrations -seq init
/home/luis/Projetos/go-expert/sqlc/sql/migrations/000001_init.up.sql
/home/luis/Projetos/go-expert/sqlc/sql/migrations/000001_init.down.sql

## subir o mysql
> docker compose up

## comando para criar o banco
migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose up

saida no terminal:
2025/05/21 19:39:13 Start buffering 1/u init
2025/05/21 19:39:13 Read and execute 1/u init
2025/05/21 19:39:13 Finished 1/u init (read 6.103067ms, ran 85.049981ms)
2025/05/21 19:39:13 Finished after 103.563461ms
2025/05/21 19:39:13 Closing source and database

## acessando o bd mysql:

> docker compose exec mysql bash
> mysql -uroot -p courses

mysql> show tables;
+-------------------+
| Tables_in_courses |
+-------------------+
| categories        |
| courses           |
| schema_migrations |
+-------------------+

## Comandos para Down Migration
> migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose down

Makefile

Foi criado esse arquivo para que os comandos sejam reduzidos. 
Para rodar as migrations up e down, e criar a migration inicial

createmigration:
	migrate create -ext=sql -dir=sql/migrations -seq init

migrate:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose up

migratedown:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose down

.PHONY: migrate migratedown createmigration

# sqlc
