alter table users
add cvv char(3) NOT NULL,
add exp char(5) NOT NULL,
modify name varchar(255) NOT NULL,
modify email varchar(255) NOT NULL,
modify contact char(8) NOT NULL,
modify creditcard char(16) NOT NULL;

UPDATE users
set creditcard = "0000000000000000", cvv = "000", exp = "00/00"
where ID = 1;

UPDATE users
set cvv = "123", exp = "09/24"
where ID = 2