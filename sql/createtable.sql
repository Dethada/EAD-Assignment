CREATE TABLE movie (
<<<<<<< HEAD
    MovieID int NOT NULL AUTO_INCREMENT,
    MovieTitle  varchar(200) NOT NULL,
    ActorList   varchar(200)    NOT NULL,
    ReleaseDate date NOT NULL,
    Synopsis    text NOT NULL,
    Duration    int NOT NULL,
    PRIMARY KEY (MovieID)
);

CREATE TABLE actor(
    ActorID int NOT NULL AUTO_INCREMENT,
    ActorName varchar(150) NOT NULL,
    ActorDesc  text NOT NULL,
    PRIMARY KEY(ActorID) 
);

CREATE TABLE MovieActor(
    MovieID int NOT NULL AUTO_INCREMENT,
    ActorID int NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (ActorID) REFERENCES actor(ActorID)
=======
   	ID int NOT NULL AUTO_INCREMENT,
    title  varchar(255) NOT NULL,
    releasedate date NOT NULL,
    synopsis    text NOT NULL,
    duration    int NOT NULL,
    imagepath varchar(255) NOT NULL,
    status varchar(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE actor(
    ID int NOT NULL AUTO_INCREMENT,
    Name varchar(255) NOT NULL,
    description  text NOT NULL,
    PRIMARY KEY(ID) 
);

CREATE TABLE MovieActor(
    movieID int NOT NULL,
    actorID int NOT NULL,
    FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (actorID) REFERENCES actor(ID)
>>>>>>> sql
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE timeslot(
    timing time NOT NULL,
<<<<<<< HEAD
    MovieID int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (timing),
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
=======
    movieID int NOT NULL,
    PRIMARY KEY (timing),
    FOREIGN KEY (movieID) REFERENCES movie(ID)
>>>>>>> sql
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

<<<<<<< HEAD
CREATE TABLE GenreID(
    GenreID int NOT NULL AUTO_INCREMENT,
    GenreName varchar(150) NOT NULL,
    GenreDesc text NOT NULL,
    PRIMARY KEY(GenreID)
);

CREATE TABLE MovieGenre(
    MovieID int NOT NULL AUTO_INCREMENT,
    GenreID int NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (GenreID) ReleaseDate Genre(GenreID)
=======
CREATE TABLE MovieGenre(
    movieID int NOT NULL,
    genreID int NOT NULL,
    FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (genreID) REFERENCES Genre(ID)
>>>>>>> sql
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE reviews(
    reviewID int NOT NULL AUTO_INCREMENT,
<<<<<<< HEAD
=======
    movieID int NOT NULL,
>>>>>>> sql
    reviewSentence text NOT NULL,
    name varchar(70) NOT NULL,
    rating int NOT NULL,
    PRIMARY KEY(reviewID)
<<<<<<< HEAD
    FOREIGN KEY(MovieID) REFERENCES movie(MovieID)
=======
    FOREIGN KEY(movieID) REFERENCES movie(ID)
>>>>>>> sql
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE users(
<<<<<<< HEAD
    userID int NOT NULL AUTO_INCREMENT,
    username varchar(100) NOT NULL,
    name varchar(70) NOT NULL,
    password char(60) NOT NULL
    role varchar(50) NOT NULL,
=======
    ID int NOT NULL AUTO_INCREMENT,
    username varchar(100) NOT NULL,
    password char(60) NOT NULL
    role varchar(50) NOT NULL,
    lastloginip varchar(15) NULL,
    lastlogintime datetime NULL,
>>>>>>> sql
    UNIQUE (username),
    PRIMARY KEY(userID)
);

<<<<<<< HEAD
CREATE TABLE GenreID(
    GenreID int NOT NULL AUTO_INCREMENT,
    GenreName varchar(150) NOT NULL,
    GenreDesc text NOT NULL,
    UNIQUE (GenreName),
    PRIMARY KEY(GenreID)
=======
CREATE TABLE Genre(
    ID int NOT NULL AUTO_INCREMENT,
    name varchar(150) NOT NULL,
    description text NOT NULL,
    UNIQUE (name),
    PRIMARY KEY(ID)
);

CREATE TABLE MovienMod(
	timelog datetime null,
	userID int NOT NULL,
	movieID int NOT NULL,
	FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (userID) REFERENCES users(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE MovieCreate(
	timelog datetime null,
	userID int NOT NULL,
	movieID int NOT NULL,
	FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (userID) REFERENCES users(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
>>>>>>> sql
);