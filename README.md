# EAD-Assignment ST0291 [![Build Status](https://travis-ci.com/PotatoDrug/EAD-Assignment.svg?token=6u9dQjLz7vCpD1gzxyL5&branch=master)](https://travis-ci.com/PotatoDrug/EAD-Assignment) [![Codecov private](https://img.shields.io/codecov/c/token/kjqDtFyGLg/github/PotatoDrug/EAD-Assignment.svg)](https://codecov.io/gh/PotatoDrug/EAD-Assignment)

Due Date: 6th August 10AM

Provide README file to provide instructions on how to setup the project.

> The assignment should be implemented using MVC Architecture. It must be completed using Java Servlets, JSPs, Java Beans, HTML, Tomcat, Eclipse and MySQL.

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
[Plugin Documentation](http://tomcat.apache.org/maven-plugin-trunk/tomcat7-maven-plugin/plugin-info.html)  
[Plugin Usage](http://tomcat.apache.org/maven-plugin-trunk/tomcat7-maven-plugin/usage.html)

## Overview

**With the successful completion of SPMovy** in Assignment 1, the company would require the implementation of shopping cart features in order for the website to conduct e-business on the web. 

You are required to modify your Assignment 1 to incorporate the requirements stated below.
Note that **MVC** is only required to be implemented for the new functional specs stated in Assignment 2. The following requirements are to be implemented using **MVC Architecture**.

## Functional Specification

### Admin

* He must be able to view a report
  * ~~List of top 10 selling movies for a month by ticket number sales.~~
  * ~~View transaction details of a particular user (username supplied by admin)~~

### General Public

* ~~Public is able to search for movies using either one of the search criteria to be displayed as a dropdown box (results should be **sorted by release date, latest released movies appear at the top of the list**):~~
* ~~Title~~
* ~~Genre~~
* ~~Actor~~
* ~~Public can register for an account to become a member. A member needs to have personal particulars that include username(unique), name, email, contact number, credit card number, password.~~ **Only Members** can purchase movie tickets. Public (Non-members) can still continue to browse the movies showing.(Use sessions/cookies to help you accomplish this)
* ~~Client side(eg javascript) validation must be done on the registration page. All fields must be entered. Ensure appropriate validation for email, contact number and password. For example, Password must contain both alphabets and numbers and be of length 8 to 16, contact number must be valid characters etc.~~
* ~~Members will be able to update their personal details~~
* Members will be able to book 1 or more movie tickets for a particular Movie Title on a particular date and time Slot.  Take note that you have to keep track of the total seats still available for a movie on a certain time slot.  For simplicity, price of a ticket will be either $8.50 on weekdays, or $13 on weekends and we can assume there’s only **1 theatre** in this application with seats from **row A-J** and **20 seats per row**. When booking the ticket(s), the user will be allowed to select the actual date and timeslot of the movie. The booking data must be stored in a **session**.
* After selection of the movie, ticket quantity, date and timeslot, members would be allowed to select available seats for the movie.
* Upon check out, your application should display the details of the ticket booking(including seat numbers, movie title, time, date), the personal particulars (i.e. name, email, contact number, credit card number), and total price as a transaction summary for users to confirm. Upon confirmation, the transaction details will be stored in the database. 

> Advanced features are worth 10%. You are allowed to suggest new functionalities for your web application. Examples include but not limited to features like forget password(email), facebook/google login, hosting of application online, usage of transaction API for database transactions, password encryption, online e-payment such as use of Stripe or PayPal testing api etc.

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

* Your program must be object-oriented with proper classes.
* Ease of maintenance and enhancements will be very important

## Assessment Guidelines

* Demonstrate the requirements stated above (80%)
* Application design and user friendliness (10%)
* Advanced Features (10%)
* Amount of individual contribution to the project
* Q&A during the interview
