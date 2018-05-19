CREATE TABLE movie (
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (movieID, actorID)
);

CREATE TABLE timeslot(
    timing datetime NOT NULL,
    movieID int NOT NULL,
    PRIMARY KEY (timing),
    FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Genre(
    ID int NOT NULL AUTO_INCREMENT,
    name varchar(150) NOT NULL,
    description text NOT NULL,
    UNIQUE (name),
    PRIMARY KEY(ID)
);

CREATE TABLE MovieGenre(
    movieID int NOT NULL,
    genreID int NOT NULL,
    FOREIGN KEY (movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (genreID) REFERENCES Genre(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (movieID, genreID)
);

CREATE TABLE reviews(
    reviewID int NOT NULL AUTO_INCREMENT,
    movieID int NOT NULL,
    reviewSentence text NOT NULL,
    name varchar(70) NOT NULL,
    rating int NOT NULL,
    createdat datetime NOT NULL,
    ip varchar(39) NOT NULL,
    PRIMARY KEY(reviewID,movieID),
    FOREIGN KEY(movieID) REFERENCES movie(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE users(
    ID int NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL,
    password char(60) NOT NULL,
    role varchar(50) NOT NULL,
    UNIQUE (username),
    PRIMARY KEY(userID)
);

DELIMITER //
CREATE  PROCEDURE `deleteProcedure`(IN tab_name VARCHAR(100), IN id INT)
BEGIN
        SET @t1 =CONCAT('DELETE FROM ', tab_name, ' WHERE ID=', id);
        PREPARE stmt3 FROM @t1;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
END //
DELIMITER ;
