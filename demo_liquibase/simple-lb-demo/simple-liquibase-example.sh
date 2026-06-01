## simple-liquibase-example.sh
## Pre-Req:
## - Running PostgreSQL database

export DB_JDBC=INSERT
export USER=INSERT
export PASSWORD=INSERT

read -r -s -p $'Press enter to review the proposed changes...' 

liquibase --url=$DB_JDBC -- user=$USER --password=$PASSWORD update-sql --changelog-file=create_table.sql 

read -r -s -p $'Changes look good! Press enter to update our database...' 

liquibase --url=$DB_JDBC  -- user=$USER --password=$PASSWORD update --changelog-file=create_table.sql 

read -r -s -p $'Oh no, a failure happened! Press enter to rollback changelog...' 

liquibase --url=$DB_JDBC  -- user=$USER --password=$PASSWORD rollback-count 1 --changelog-file=create_table.sql 