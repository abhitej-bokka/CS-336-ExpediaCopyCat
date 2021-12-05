<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight search</title>
</head>
<body>
	Welcome to the searching page!
	<br>
	<br>
	
	<form action="FlightSearchQuery.jsp" method="POST">
	
		Filters:
	
		<label for="maxPrice">Max Price:</label>
	  	<input type="text" id="maximumPriceFilter" name="maximumPriceFilter"><br>
	  	<label for="numberOfStops">Number of Stops:</label>
	  	<input type="text" id="numberOfStopsFilter" name="numberOfStopsFilter"><br>
	  	<label for="specificAirline">Specific Airline:</label>
	  	<input type="text" id="specificAirlineFilter" name="specificAirlineFilter"><br>
	  	<label for="takeOffTime">Take Off Time: (enter time in Universal Format, e.g 13:40)</label>
	  	<input type="time" id="takeOffStartTime" name="takeOffStartTime" min="00:00" max="23:59">
	  	<input type="time" id="takeOffEndTime" name="takeOffEndTime" min="00:00" max="23:59"><br>
	  	<label for="landingTime">Landing Time: (enter time in Universal Format, e.g 13:40)</label>
	  	<input type="time" id="landingTimeStartTime" name="landingTimeStartTime" min="00:00" max="23:59">
	  	<input type="time" id="landingTimeEndTime" name="landingTimeEndTime" min="00:00" max="23:59"><br><br>
	  	
	  	<br>
	  	<br>
	  	Sort By:
	  	<select name="sortByDropDown">
		    <option value="priceSortBy" selected>Price (asc)</option>
		    <option value="takeOffTime">Take Off Time (asc)</option>
		    <option value="landingTime">Landing Time (asc)</option>
		    <option value="flightDuration">Flight Duration (asc)</option>
	    </select>
	
		<label for="start">Start Date: </label>
		<input type="date" id="start" name="trip-start" value="2021-12-05" min="202021-12-05" max="2022-03-05">
    
	    <br>
	    <br>
	    <br>
    
		<label for="start">Start Date: </label>
		<input type="date" id="start" name="trip-start" value="2021-12-05" min="202021-12-05" max="2022-03-05">
		<label for="start">End Date: </label>
		<input type="date" id="end" name="trip-end" value="2021-12-08" min="202021-12-08" max="2022-03-08">
		
		<br>
		
		<input type="radio" id="oneWay" name="tripType" value="isOneWay" checked>
		<label for="child">One Way</label>
		<input type="radio" id="roundTrip" name="tripType" value="isRoundTrip">
		<label for="adult">Round Trip</label><br>
		<input type="radio" id="searchByOneDate" name="searchDateType" value="searchByOneDate" checked>
		<label for="oneWay">Search by single date</label>
		<input type="radio" id="searchByFlexibleDate" name="searchDateType" value="searchByFlexibleDate">
		<label for="roundtrip">Search by flexible date</label><br>
		
		<br>
		
		<input type="submit" name="submit" value="Search!"/>
		
		
    </form>
		
		<!-- <br/>
        <select name="clr">
           <option>Red</option>
           <option>Blue</option>   
           <option>Green</option>
           <option>Pink</option>
        </select> -->
</body>
</html>