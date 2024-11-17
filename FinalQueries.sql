--Jonah Carpenter


--2A:. Write the SQL statement that will display the following information for all car rental reservations, listing in ascending order by last name
SELECT carCust2023.fname, carCust2023.lname, auto2023.make, auto2023.model, rental2023.startDate, rental2023.endDate, 
(DATEDIFF(rental2023.endDate, rental2023.startDate) * auto2023.rate) AS rentCharge
FROM rental2023
JOIN carCust2023 ON rental2023.driversLicense = carCust2023.driversLicense
JOIN auto2023 ON rental2023.VIN = auto2023.VIN
ORDER BY carCust2023.lname ASC;

--2B:Write the SQL statement that will display the following information for a specified username as shown in the sample output
SELECT carCust2023.fname, carCust2023.lname, auto2023.make, auto2023.model, rental2023.endDate,
DATEDIFF(rental2023.endDate, rental2023.startDate) AS rentalDays,
(DATEDIFF(rental2023.endDate, rental2023.startDate) * auto2023.rate) AS rentalCharge,
payment2023.cType
FROM rental2023
JOIN carCust2023 ON rental2023.driversLicense = carCust2023.driversLicense
JOIN auto2023 ON rental2023.VIN = auto2023.VIN
JOIN payment2023 ON rental2023.rentNum = payment2023.rentNum
WHERE carCust2023.username = :kander
ORDER BY rental2023.endDate DESC;

--2C:Write the SQL statement that will display all of the distinct car categories
SELECT DISTINCT category
FROM auto2023
WHERE category IN ('Compact', 'Fullsize', 'SUV', 'Truck or Van');

--2D:Write the SQL statement that will display the total number of vehicles for each make and model in the rental fleet (you will need to use both an aggregate and GROUP BY to do this). Order by make, then model, in ascending order
SELECT make, model, COUNT(*) AS total_vehicles
FROM auto2023
GROUP BY make, model
ORDER BY make ASC, model ASC;
