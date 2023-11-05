postgres:
	docker run --name pg16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres:16-alpine

createdb:
	docker exec -it pg16 createdb --username=root --owner=root bank

dropdb:
	docker exec -it pg16 dropdb bank 

migrateup:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc