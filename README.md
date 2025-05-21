# 🛠️ Projeto: crud-sqlc-migration

Este projeto demonstra uma estrutura simples e funcional de CRUD utilizando Go, SQLC, MySQL e migrations com o `golang-migrate`. O objetivo é mostrar como organizar um projeto com:

- Migrations versionadas e aplicáveis via CLI
- Geração automática de código SQL fortemente tipado com SQLC
- Banco de dados MySQL rodando em container com Docker Compose

---

## ✅ Requisitos

Antes de iniciar, é necessário ter instalados:

- [Go](https://go.dev/dl/) 1.22 ou superior
- [Docker e Docker Compose](https://docs.docker.com/get-docker/)
- [`sqlc`](https://docs.sqlc.dev/en/latest/overview/install.html)
- [`migrate`](https://github.com/golang-migrate/migrate) (CLI)

## 📁 Migrations Iniciais

migrate create -ext=sql -dir=sql/migrations -seq init

Isso irá gerar os arquivos:

sql/migrations/000001_init.up.sql
sql/migrations/000001_init.down.sql

---

## 🐬 Subir o MySQL com Docker
> docker compose up

## comando para criar o banco
migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose up

saida no terminal:
2025/05/21 19:39:13 Start buffering 1/u init
2025/05/21 19:39:13 Read and execute 1/u init
2025/05/21 19:39:13 Finished 1/u init (read 6.103067ms, ran 85.049981ms)
2025/05/21 19:39:13 Finished after 103.563461ms
2025/05/21 19:39:13 Closing source and database

---

## 🐚 Acessando o banco MySQL no container

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

---

## Comandos para Down Migration
> migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose down

---

## 📄 Makefile

Para simplificar os comandos, foi criado um Makefile com os targets abaixo:

createmigration:
	migrate create -ext=sql -dir=sql/migrations -seq init

migrate:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose up

migratedown:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/courses" -verbose down

.PHONY: migrate migratedown createmigration


Agora você pode rodar:

make createmigration – Cria uma nova migration.

make migrate – Executa as migrations pendentes.

make migratedown – Desfaz a última migration.

---

## 📦 Gerando código com SQLC
Com sua estrutura pronta e migrations aplicadas, gere o código Go com:

> sqlc generate
Isso criará os arquivos em internal/db/ conforme configurado no sqlc.yaml.



