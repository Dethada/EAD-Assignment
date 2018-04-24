CREATE TABLE movie (
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
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE timeslot(
    timing time NOT NULL,
    MovieID int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (timing),
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

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
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE reviews(
    reviewID int NOT NULL AUTO_INCREMENT,
    reviewSentence text NOT NULL,
    name varchar(70) NOT NULL,
    rating int NOT NULL,
    PRIMARY KEY(reviewID)
    FOREIGN KEY(MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE users(
    userID int NOT NULL AUTO_INCREMENT,
    username varchar(100) NOT NULL,
    name varchar(70) NOT NULL,
    password char(60) NOT NULL
    role varchar(50) NOT NULL,
    UNIQUE (username),
    PRIMARY KEY(userID)
);

CREATE TABLE GenreID(
    GenreID int NOT NULL AUTO_INCREMENT,
    GenreName varchar(150) NOT NULL,
    GenreDesc text NOT NULL,
    UNIQUE (GenreName),
    PRIMARY KEY(GenreID)
);