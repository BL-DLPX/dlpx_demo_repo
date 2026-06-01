--liquibase formatted sql

--changeset simple_example:1 labels:create_table
--comment: Table creation
CREATE TABLE doctors( 
   doctor_id INT GENERATED ALWAYS AS IDENTITY, 
   first_name VARCHAR(80) NOT NULL, 
   last_name VARCHAR(80) NOT NULL 
); 
--rollback DROP TABLE IF EXISTS doctors; 