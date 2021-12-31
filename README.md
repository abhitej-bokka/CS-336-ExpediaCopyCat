# 336TravelProject


### Introduction

In this project, we designed and implemented a relational database system to support the operations of an online travel reservation system. 
We used HTML for the user interface, MySQL for the database server, and Java, JDBC for connectivity between the user interface and 
the database server. 
We used a web server that to host our web application (Tomcat) as well as a MySQL server.

### Customer-Level Functionality
Customers should be thought of as online airline ticket buyers and should be able to easily 
browse your online travel reservation system on the web and buy flight tickets. In particular, they 
should be able to first search about the following type of flights:

 - One-Way on a specific date
 - Round-Trip on specific dates
 - One-Way/ Round-Trip on flexible dates (+/- 3 days)

A customer should also be able to: 
 - Browse the available resulting flights 
 - Sort flights by different criteria (price, take-off time, landing time, duration of flight)
 - Filter the list of flights by various criteria (price, number of stops, airline, take-off times, 
landing times)
 - Make flight reservations
 - Cancel their flight reservations (if it is business or first class)
    - If there are people on the waiting list, they should receive an alert that there is an available seat, and be able to proceed with paying their ticket and complete the 
reservation.

 - Enter the waiting list if the flight is full
 - View all the past reservations with their details
 - View all the upcoming reservations with their details
 - Be able to browse and send questions to customer representatives
 - Be able to search questions and answers by keywords
