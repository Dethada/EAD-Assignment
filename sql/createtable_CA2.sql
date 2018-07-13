CREATE TABLE seats(
	hall_column char(2) NOT NULL,
	hall_row char(1) NOT NULL,
	primary key (hall_row,hall_column)
);

CREATE TABLE bookseats(
	price decimal(5,2) NOT NULL,
	ticketID char(65) NOT NULL,
	hall_column char(2) NOT NULL,
	hall_row char(1) NOT NULL,
	transactionID char(65) NOT NULL,
	movietime time NOT NULL,
    moviedate date NOT NULL,
    movieID int NOT NULL,
    primary key (hall_row,hall_column,transactionID,moviedate,movietime,movieID),
    foreign key (transactionID) references transaction(ID) 
	ON DELETE CASCADE 
	ON UPDATE CASCADE,
	foreign key (movieID,movietime,moviedate) references timeslot(movieID,movietime,moviedate)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	foreign key (hall_row,hall_column) references seats(hall_row,hall_column)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE transaction(
	ID char(65) NOT NULL,
	at datetime NOT NULL, 
	primary key(ID)
);

CREATE TABLE price(
	day	char(3) NOT NULL,
	price decimal(5,2) NOT NULL,
	primary key (day)
);

