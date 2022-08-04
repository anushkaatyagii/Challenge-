use challenges;

drop procedure if exists question2;

delimiter $$
create procedure question2(in start_date date, in start_time time)
begin
	set @init = cast(start_date as datetime) + cast(start_time as time);
    select date_format(@init,'%Y %M %d') as 'Start Date',
		SUM( `<vol>` * `<close>` ) / SUM(`<vol>`) as VWAP,
		start_time as 'Start Time', DATE_ADD(start_time, INTERVAL 5 HOUR) as 'End Time'
		from (
				select * from sample_dataset2 
					where str_to_date(`<date>`,'%Y%m%d%H%i') BETWEEN
					str_to_date(@init, '%Y%m%d%H%i') AND 
					DATE_ADD(str_to_date(@init, '%Y%m%d%H%i'), INTERVAL 5 HOUR)
			 ) as ds2
		group by `<ticker>`;
end$$
delimiter ;

call question2('2010-10-14','10:00:00');
