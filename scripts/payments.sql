/* Create the `payments` table. */
create table payments (id serial primary key not null, user_id int, amount int, issue_date timestamp without time zone);

/* Insert sample sales data. */
insert into payments (amount, issue_date) values (100, '2016-02-03 01:16:19');
insert into payments (amount, issue_date) values (200, '2016-02-03 12:41:42');
insert into payments (amount, issue_date) values (300, '2016-02-03 13:52:08');
insert into payments (amount, issue_date) values (101, '2016-02-12 12:51:30');
insert into payments (amount, issue_date) values (400, '2016-02-18 22:16:06');
insert into payments (amount, issue_date) values (300, '2016-02-18 23:01:48');
insert into payments (amount, issue_date) values (110, '2016-02-19 16:17:44');
insert into payments (amount, issue_date) values (120, '2016-02-20 23:07:13');
insert into payments (amount, issue_date) values (150, '2016-02-22 04:08:58');
insert into payments (amount, issue_date) values (106, '2016-02-27 11:27:39');
insert into payments (amount, issue_date) values (108, '2016-02-27 14:31:13');
insert into payments (amount, issue_date) values (109, '2016-03-06 10:13:57');
insert into payments (amount, issue_date) values (202, '2016-03-16 02:04:42');
insert into payments (amount, issue_date) values (305, '2016-03-30 15:03:45');
insert into payments (amount, issue_date) values (120, '2017-01-05 13:07:16');

/* OPTION 1: Get the day with most sales (using a CTE). */
with daily as (select date_trunc('day', issue_date) as day, sum(amount) as total from payments where issue_date >= '2016-01-01 00:00:00.000000' and issue_date <= '2016-12-31 23:59:59.999999' group by day) select day, total from daily order by total desc limit 1;

/* OPTION 2: Get the day with most sales (using a subquery). */
select day, total from (select date_trunc('day', issue_date) as day, sum(amount) as total from payments where issue_date >= '2016-01-01 00:00:00.000000' and issue_date <= '2016-12-31 23:59:59.999999' group by day) as daily order by total desc limit 1;

/*
Expected identical result of the queries above:

         day         | total
---------------------+-------
 2016-02-18 00:00:00 |   700
*/
