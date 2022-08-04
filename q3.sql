drop procedure if exists solution3;
delimiter $$
create procedure solution3()
begin
	create temporary table PriceDifference
		select ds1.Date as Date, abs(ds1.open - ds2.close) as PriceRange from 
		-- selects the opening price of first trade of the day 
			(select Date, Open from sample_dataset3 
				group by Date) as ds1 
				join
		-- selects the closing price of the last trade of the day
			(select d1.Date as Date,d2.Close from
			-- selects the Time of the last trade and joins that with the closing rate
				(select Date, max(Time) as Time, Close from sample_dataset3 group by Date) as d1 
				join 
				(select Date, Time, Close from sample_dataset3 ) as d2
				on d1.Date = d2.Date and d1.Time = d2.Time
			) as ds2
			on ds1.date = ds2.date
		order by PriceRange
		desc
		limit 3;

	create temporary table High
		select a1.Date as Date, a2.time as Time from
			(select Date, max(High) as maxHigh from sample_dataset3 group by Date) as a1
			join 
			(select Date, time, high from sample_dataset3) as a2
			on a1.date = a2.date and a1.maxHigh = a2.high;
	select p.Date as Date, p.PriceRange as PriceRange, h.Time as Time from 
		PriceDifference as p join High as h
		on p.Date = h.Date
		order by Date
		desc;
	drop temporary table PriceDifference;
	drop temporary table High;
end$$
delimiter ;

call solution3();

-- drop temporary table PriceDifference;
-- drop temporary table High