create database hotel_booking;
use hotel_booking;
show databases;
select * from hotel_bookings;

# 1. Where do the guests come from?   --------------------------------

select country,sum(adults+children) "total_guest" from hotel_bookings group by Country;

# 2. How much do guests pay for a room per night?   ---------------------------------

## Total Revenue

Select reserved_room_type,sum(adults+children) "total_guest",
sum((stays_in_week_nights+stays_in_weekend_nights)*adr) "total_revenue"
from hotel_bookings group by reserved_room_type
order by reserved_room_type;

## Week wise revenue

Select reserved_room_type,sum(adults+children) "total_guest",
sum((stays_in_week_nights)*adr) "Total_revenue_week",sum((stays_in_weekend_nights)*adr) "total_revenue_weekend"
from hotel_bookings group by reserved_room_type
order by reserved_room_type;

# 3. How does the price per night vary over the year?  -------------------------------------

## Total Revenue

select arrival_date_year,hotel,sum((stays_in_week_nights+stays_in_weekend_nights)*adr) "total_revenue"
from hotel_bookings group by arrival_date_year,hotel
order by arrival_date_year;

## Weekwise total revenue

Select Hotel,sum((stays_in_week_nights)*adr) "Total_revenue_week",
sum((stays_in_weekend_nights)*adr) "total_revenue_weekend"
from hotel_bookings group by hotel;


# 4. Which are the most busy month?  ---------------------------------------------------------

 select reservation_status_date,hotel,monthname(reservation_status_date) "Month_name",year(reservation_status_date)"Year_",sum(adults+children) "Total_guest" 
 from hotel_bookings group by reservation_status_date,hotel
 order by reservation_status_date,Month_name,year_;
 
 # 5. Bookings by market segment?  --------------------------------------------------------
 
 Select market_segment,hotel,count(market_segment) "Booking_per_market_segment"  from hotel_bookings
 group by market_segment,hotel order by market_segment;
 
 ## In paercentage
 
select market_segment,count(*)*100.0/sum(count(*)) over() as "market_segment_percentage"
from hotel_bookings group by market_segment order by market_segment;

 # 6. How many bookings were canceled?  ----------------------------------------------------------
 
 select hotel,sum(is_canceled) booking_canceled,                                             #  # Hotel wise booking canceled
 count(*)*100.0/sum(count(*)) over() as "Percentage_of_cancelation"
 from hotel_bookings group by hotel;  
 
 select is_canceled,sum(is_canceled) `total booking canceled` from hotel_bookings where is_canceled=1  # Total booking canceled
 group by is_canceled ;
 
 # 7. Which month have the highest number of cancelations?  -----------------------------------------------
 
 select arrival_date_month,count(is_canceled),count(*)*100.0/sum(count(*)) over() as "percentage_of_cancelation" 
 from hotel_bookings group by arrival_date_month order by arrival_date_month; 
 
 
 
 
