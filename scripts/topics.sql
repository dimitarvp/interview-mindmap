/* Create the `topics` table. */
create table topics (id serial primary key not null, name varchar(255), parent_id int, foreign key (parent_id) references topics(id));

/*
Insert sample topic data. This heavily relies on the order of insertions and is
dependent on the primary ID increasing by one on each insetion.
*/
insert into topics (name, parent_id) values ('Lord of the Rings', null);

/* Root topics. */
insert into topics (name, parent_id) values ('Story', 1);
insert into topics (name, parent_id) values ('Characters', 1);
insert into topics (name, parent_id) values ('Setting', 1);

/* Story topics (in this case parts). */
insert into topics (name, parent_id) values ('Part I', 2);
insert into topics (name, parent_id) values ('Part II', 2);
insert into topics (name, parent_id) values ('Part III', 2);

/* Characters. */
insert into topics (name, parent_id) values ('Arwen', 3);
insert into topics (name, parent_id) values ('Galadriel', 3);
insert into topics (name, parent_id) values ('Aragorn', 3);
insert into topics (name, parent_id) values ('Celeborn', 3);
insert into topics (name, parent_id) values ('Gimli', 3);
insert into topics (name, parent_id) values ('Legolas', 3);
insert into topics (name, parent_id) values ('Sam', 3);
insert into topics (name, parent_id) values ('Frodo', 3);
insert into topics (name, parent_id) values ('Merry', 3);
insert into topics (name, parent_id) values ('Pippin', 3);
insert into topics (name, parent_id) values ('Gandalf', 3);

/* Setting(s), which are more like tags. */
insert into topics (name, parent_id) values ('Genres', 4);
insert into topics (name, parent_id) values ('Races', 4);
insert into topics (name, parent_id) values ('Locations', 4);

/* Genres. */
insert into topics (name, parent_id) values ('Fantasy', 19);
insert into topics (name, parent_id) values ('Fiction', 19);
insert into topics (name, parent_id) values ('Tale', 19);

/* Races. */
insert into topics (name, parent_id) values ('Hobbits', 20);
insert into topics (name, parent_id) values ('Humans', 20);
insert into topics (name, parent_id) values ('Elves', 20);
insert into topics (name, parent_id) values ('Dwarves', 20);
insert into topics (name, parent_id) values ('Orcs', 20);

/* Locations. */
insert into topics(name, parent_id) values ('The Shire', 21);
insert into topics(name, parent_id) values ('Bree', 21);
insert into topics(name, parent_id) values ('Isengard', 21);
insert into topics(name, parent_id) values ('Moria', 21);
insert into topics(name, parent_id) values ('Mordor', 21);

/* Select all direct descendants of a given root topic ID (level 1 children). */

select name from topics where parent_id = 1;
/*
Expected result:

name
------------
Story
Characters
Setting
*/

select name from topics where parent_id = 19;
/*
Expected result:

name
---------
Fantasy
Fiction
Tale
*/

/* Select all direct descendants of the direct descendants of a given root topic ID (level 2 children). */

select name from topics where parent_id in (select id from topics where parent_id = 1);
/*
Expected result:

name
-----------
Part I
Part II
Part III
Arwen
Galadriel
Aragorn
Celeborn
Gimli
Legolas
Sam
Frodo
Merry
Pippin
Gandalf
Genres
Races
Locations
*/

select name from topics where parent_id in (select id from topics where parent_id = 4);
/*
Expected result:

name
-----------
Fantasy
Fiction
Tale
Hobbits
Humans
Elves
Dwarves
Orcs
The Shire
Bree
Isengard
Moria
Mordor
*/
