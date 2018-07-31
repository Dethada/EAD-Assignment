ALTER TABLE users
	ADD cardname varchar(26) NOT NULL

UPDATE users
set cardname = "admin"
where ID = 1

UPDATE users
set cardname = "test"
where ID = 2

UPDATE users
set cardname = "testtube"
where ID = 3