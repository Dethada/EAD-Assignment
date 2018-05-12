# EAD-Assignment ST0291 [![Build Status](https://travis-ci.com/PotatoDrug/EAD-Assignment.svg?token=6u9dQjLz7vCpD1gzxyL5&branch=master)](https://travis-ci.com/PotatoDrug/EAD-Assignment) [![Codecov private](https://img.shields.io/codecov/c/token/kjqDtFyGLg/github/PotatoDrug/EAD-Assignment.svg)](https://codecov.io/gh/PotatoDrug/EAD-Assignment)

Due Date: 21st May 1000hrs

Provide README file to provide instructions on how to setup the project.

> The assignment should be implemented using JSPs, HTML, Apache Tomcat, Eclipse and MySql.

## Deployment

### Windows

[Install Maven](https://www.mkyong.com/maven/how-to-install-maven-in-windows/)

[Set ENV Variable Windows 10](https://superuser.com/questions/949560/how-do-i-set-system-environment-variables-in-windows-10)

```powershell
# Go to your tomcat folder > bin
# start tomcat server
>.\startup.bat
# Go to your project folder
# Build war file
> mvn clean install -DskipTests
# Deploy to tomcat
> mvn tomcat7:deploy
# stop tomcat server
>.\shutdown.bat
```

## Overview

**SPMovy** is considering to create an online movie booking portal to allow the public to book for movie tickets online. Before it launches its online booking service, it requires a web application to computerize its movie database and allow the public to view its movies details online.

For the time being, the system only allows the following roles:

* Administrator
* General Public (does not require login)

It is expected that more roles will be added in the near future, and the database may have changes to cater to additional requirements in the 2nd phase.

You are tasked to design and develop a web application for the company to maintain its movie database and to allow viewers to access the movie information online.

## Functional Specification

### Admin

* ~~Can maintain the movies database. The login credentials are to be stored in a database table, which you are required to use this table to authenticate the administrator.~~

* ~~He must be able to add new movie genre categories to the database. A database **genre table is required** for management of genre info and details.~~

* ~~He must be able to add new movie data to the database. For each movie, the~~
  ~~following minimum information must be recorded~~

  * Movie ID (PK, Auto-Increment, Int)
  * Movie Title
  * Actor List
  * Release Date
  * Synopsis
  * Genre (1 movie can have multiple genres, set a FK to link with genre table)
  * Duration (in mins)
  * Movie Time slots

  > We can suggest other fields to be included.

* ~~Must be able to update and delete movies from the database.~~

* ~~Must be able to delete movie genres created previously~~

* ~~Each movie should have an image associated. The system will assign a default image if there is no existing image.~~

### General Public

* ~~There should be a movies page which allows users to see current movies. This page should~~
  ~~show the movie picture and the title and duration as summary. Clicking the~~
  ~~movie picture would display the full details of the movie in another separate~~
  ~~page, including the reviews of the movie.~~ 
* ~~Users can choose to filter current movies based on the available genres. This can be~~
  ~~through usage of a dropdown box with the available movie genres (retrieved from~~
  ~~database table).~~
* ~~Users can write reviews on the movie by giving it a rating and entering the comments~~
  ~~and name. The ‘write review’ button should be shown on the movie details page.~~
  ~~A review table with the review details and foreign key linking to the movie table should be created in the database.~~
* ~~Login not required~~

## System Specification

### Website Design

* There should be a menu that caters to users with different roles.
* Navigation should be easy and intuitive
* The Website must be attractive, especially for the public
* For internal users, the ease of use will be the most important factor

### Database Design

* The database must be properly designed based on Functional Specifications
* Design must cater for future enhancements

### Program Design

* Ease of maintenance and enhancements will be very important

## Assessment Guidelines

* Demonstrate the requirements stated above (80%)
* Application design and user friendliness (10%)
* Advanced Features (10%)
* Amount of individual contribution to the project
* Q&A during the interview
