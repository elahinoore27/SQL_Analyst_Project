use ola;

-- 1. Retrieve all successful bookings:

create view successful_boking as
select *from bookings
where Booking_status='Success';

--  2. Find the average ride distance for each vehicle type:

create view average_ride_vehicle as
select Vehicle_type,avg(Ride_Distance) as Average_Distance
from bookings
group by Vehicle_type;

--  3. Get the total number of cancelled rides by customers:
create view Canceled_ride_by_customer as
select count(*) from bookings
where Booking_Status='Canceled by Customer';

--  4. List the top 5 customers who booked the highest number of rides:

create view Top_5_customer_by_ride as
select Customer_ID,count(Booking_ID) as total_ride
from bookings
group by customer_ID
order by total_ride desc limit 5;

--  5. Get the number of rides cancelled by drivers due to personal and car-related issues:

create view cancel_ride_by_driver as
select count(*) as cancel_by_driver
from bookings
where Canceled_Rides_by_Driver='Personal & Car related issue';


--  6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

create view max_min_Driver_Rating as
select  max(Driver_Ratings) as maximum_Rating, min(Driver_Ratings) as Minimum_Rating
from bookings
where Vehicle_Type='Prime Sedan';

--  7. Retrieve all rides where payment was made using UPI:

create view UPI_payment as
select *from bookings
where Payment_Method="UPI";

--  8. Find the average customer rating per vehicle type:

create view Average_Rating_Per_Vehicle as
select Vehicle_Type, avg(Customer_Rating) as Avg_Customer_Rating
from bookings
group by Vehicle_Type;

--  9. Calculate the total booking value of rides completed successfully: 

create view total_successful_value_ride as
select sum(Booking_Value) as Total_successful_value
from bookings
where Booking_Status='Success';

-- 10. List all incomplete rides along with the reason:

create view incompete_ride_reason as
select Booking_ID,Incomplete_Rides_Reason
from bookings
where Incomplete_Rides='Yes';


