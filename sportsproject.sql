create schema sportsproject;

use sportsproject;

start transaction;

                                                                                 -- Leagues                         1
CREATE TABLE Leagues (
    league_id INT PRIMARY KEY,
    league_name VARCHAR(100) NOT NULL,
    level VARCHAR(50)
);
INSERT INTO Leagues VALUES 
(1, 'Premier League', 'Top Division'),
(2, 'Championship', 'Second Division');
select*from leagues;



																			      -- Team Table                     2
CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    coach_name VARCHAR(100),
    league_id INT,
    FOREIGN KEY (league_id) REFERENCES Leagues(league_id)
);
INSERT INTO Teams VALUES
(101, 'Chennai Hawks', 'K. Suresh', 1),
(102, 'Mumbai Warriors', 'R. Sharma', 1),
(103, 'Delhi Dynamos', 'A. Iyer', 1),
(104, 'Bangalore Bulls', 'V. Kohli', 2),
(105, 'Hyderabad Strikers', 'B. Kumar', 2);
select *from teams;
select*from teams t  join  leagues l on t.league_id = l.league_id;

                                                                                      -- players                   3
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

INSERT INTO Players VALUES
-- Team 101: Chennai Hawks
(201, 'Arjun Reddy', 'Striker', 101),
(202, 'Rahul Mehra', 'Midfielder', 101),
(203, 'Karthik Das', 'Defender', 101),
(204, 'Siddhu Nair', 'Goalkeeper', 101),
(205, 'Jeevan Lal', 'Winger', 101),

-- Team 102: Mumbai Warriors
(206, 'Neeraj Shah', 'Striker', 102),
(207, 'Imran Khan', 'Midfielder', 102),
(208, 'Lakshman Rao', 'Defender', 102),
(209, 'Amit Kumar', 'Goalkeeper', 102),
(210, 'Harsh Patel', 'Winger', 102),

-- Team 103: Delhi Dynamos
(211, 'Vijay Prakash', 'Striker', 103),
(212, 'Sanjay Rao', 'Midfielder', 103),
(213, 'Dinesh Roy', 'Defender', 103),
(214, 'Ravi Varma', 'Goalkeeper', 103),
(215, 'Manoj Shetty', 'Winger', 103),

-- Team 104: Bangalore Bulls
(216, 'Ajay Menon', 'Striker', 104),
(217, 'Ravi Teja', 'Midfielder', 104),
(218, 'Pranav Joshi', 'Defender', 104),
(219, 'Kiran Dev', 'Goalkeeper', 104),
(220, 'Sahil Bhatia', 'Winger', 104),

-- Team 105: Hyderabad Strikers
(221, 'Siddharth Krishnan', 'Striker', 105),
(222, 'Vikram Naidu', 'Midfielder', 105),
(223, 'Karan Bedi', 'Defender', 105),
(224, 'Naveen Raj', 'Goalkeeper', 105),
(225, 'Anand Iqbal', 'Winger', 105);
select *from players;
select* from  players p join teams t on t.team_id=p.team_id;

																				  -- Matches                       4
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    match_date DATE NOT NULL,
    team1_id INT,
    team2_id INT,
    winner_team_id INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Teams(team_id)
);
INSERT INTO Matches VALUES
(301, '2025-07-01', 101, 102, 101),
(302, '2025-07-03', 103, 104, 104),
(303, '2025-07-05', 102, 105, 105),
(304, '2025-07-07', 101, 103, 101);

SELECT 
    m.match_id,
    m.match_date,
    t1.team_name AS Team_One,
    t2.team_name AS Team_Two,
    t3.team_name as winner_team
    FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
join teams t3 on m.winner_team_id = t3.team_id;


                                                                                     -- scores                     5
CREATE TABLE Scores (
    score_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    points_scored INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);
INSERT INTO Scores VALUES
-- Match 301: Chennai Hawks vs Mumbai Warriors
(401, 301, 201, 2), -- Arjun Reddy (Striker, Chennai)
(402, 301, 202, 1), -- Rahul Mehra (Midfielder, Chennai)
(403, 301, 204, 1), -- Neeraj Shah (Striker, Mumbai)
(404, 301, 207, 1), -- Imran Khan (Midfielder, Mumbai)

-- Match 302: Delhi Dynamos vs Bangalore Bulls
(405, 302, 211, 3), -- Vijay Prakash (Striker, Delhi)
(406, 302, 212, 1), -- Sanjay Rao (Midfielder, Delhi)
(407, 302, 216, 2), -- Ajay Menon (Striker, Bangalore)
(408, 302, 217, 1), -- Ravi Teja (Midfielder, Bangalore)

-- Match 303: Mumbai Warriors vs Hyderabad Strikers
(409, 303, 206, 1), -- Neeraj Shah (Striker, Mumbai)
(410, 303, 210, 2), -- Harsh Patel (Winger, Mumbai)
(411, 303, 221, 2), -- Siddharth Krishnan (Striker, Hyderabad)
(412, 303, 224, 1), -- Naveen Raj (Goalkeeper, Hyderabad)

-- Match 304: Chennai Hawks vs Delhi Dynamos
(413, 304, 205, 1), -- Jeevan Lal (Winger, Chennai)
(414, 304, 214, 2), -- Ravi Varma (Goalkeeper, Delhi)
(415, 304, 213, 1); -- Dinesh Roy (Defender, Delhi)

-- Tcl
SELECT * FROM scores s JOIN matches m ON s.match_id = m.match_id JOIN players p ON s.player_id = p.player_id;
    savepoint sp1;



ALTER TABLE leagues MODIFY COLUMN level text ;
select*from leagues;
describe leagues;
savepoint sp2;

ALTER TABLE leagues
ADD CONSTRAINT l_league_name UNIQUE (league_name);
alter table leagues drop constraint l_league_name; 
savepoint sp3;
rollback ;
commit;

-- DML
insert into teams ( team_id ,team_name ,coach_name ,league_id) values (6,'goa hulks','P.hari',2);
delete from  teams where team_id=6;
update teams set coach_name ='p.hari' where coach_name ='k. suresh';

-- DDL
Drop table matches;
truncate table  matches;
ALTER TABLE matches 
ADD COLUMN  match_time  enum('mrng','afternoon' ,'evening');
describe matches ;
alter table matches  drop column match_time;
alter table players add column age int check(age>18);
alter table players drop  column age;

-- DQL
select  *from players;
select*from scores;
select*from teams;
select* from leagues;
select*from matches;
SELECT l.league_name, COUNT(t.league_id)  FROM leagues l  JOIN teams t  ON l.league_id = t.league_id GROUP BY l.league_name HAVING COUNT(t.league_id) > 1;
SELECT l.league_name, COUNT(t.league_id) as teams FROM  leagues l  JOIN teams t ON l.league_id = t.league_id GROUP BY l.league_name having count(l.league_id)<2;
SELECT *
FROM leagues
JOIN teams  ON leagues.league_id = teams.league_id
WHERE teams.league_id = '2' and teams.coach_name =  'V. Kohli';

select * from scores;

select * from players;

SELECT *
FROM scores s
JOIN players p ON s.player_id= p.player_id
WHERE s.points_scored >2 ;


SELECT player_name
FROM players
ORDER BY player_name DESC
LIMIT 1;

SELECT 
    l.league_name, COUNT(t.league_id)
FROM
    leagues l
        JOIN
    teams t ON l.league_id = t.league_id
GROUP BY l.league_name;
select *from scores;
select*from players;
SELECT * FROM scores s JOIN players p ON s.player_id= p.player_id WHERE p.player_name = 'rahul mehra' AND points_scored <=1;

select*from players;
select* from matches;

select m.winner_team_id, m.match_date, t.team_name
from matches m
join players p on m.winner_team_id = p.team_id join teams t on t.team_id = m.winner_team_id
where m.winner_team_id =101  and m.match_date ='2025-07-01';


-- where and having
SELECT *FROM players p JOIN scores s ON  p.player_id = s.player_id  WHERE s.player_id =201;
SELECT l.league_name, COUNT(t.league_id) AS teams FROM Leagues l JOIN Teams t ON l.league_id = t.league_id GROUP BY l.league_name HAVING COUNT(t.league_id) = 2;


-- limit and offset
SELECT * FROM  teams ORDER BY team_name DESC   LIMIT 1 offset 1 ;

-- group by and order by

SELECT l.league_name, COUNT(t.league_id) as teams FROM leagues l left JOIN teams t ON l.league_id = t.league_id GROUP BY l.league_name ;
SELECT player_name FROM players ORDER BY player_name DESC LIMIT 1;

-- joins
      -- right join 
SELECT * FROM scores s right JOIN players p ON s.player_id= p.player_id WHERE s.points_scored ;
     -- left join 
SELECT * FROM scores s left JOIN players p ON s.player_id= p.player_id WHERE s.points_scored ;
     -- cross join 
select * from teams t cross join players p order by t.team_id asc  ;
	-- inner join
select * from teams t inner join players p on t.team_id =p.team_id;
     -- full join
 select* from  players
 UNION
 select*from teams;
 
 -- Stored procedure
 DELIMITER //

CREATE PROCEDURE gethari()
BEGIN
    SELECT * 
    FROM players p 
    JOIN scores s ON p.player_id = s.player_id 
    WHERE s.player_id = 201;
END //

DELIMITER ;
 
 -- string functions
 select team_name ,upper(team_name) from teams ;
 select team_name,lower(team_name) from teams;
 select length(team_name) from teams ;
 select SUBSTRING(team_name ,1 , 3) from teams ;
 SELECT SUBSTRING(team_name FROM 1 FOR 3) FROM teams;
 select left(team_name,5) from teams ;
 select right (team_name,3) from teams ;
 select trim(concat(' ',team_name,' '))from teams;
 select concat(team_name,'-','team') from teams ;
 select reverse(team_name) from teams ;
 select locate('bulls',team_name)from teams ;
 
 -- view 
 CREATE VIEW hari as
 SELECT l.league_name, COUNT(t.league_id) as teams FROM leagues l left JOIN teams t ON l.league_id = t.league_id GROUP BY l.league_name ;
 select* from hari;
 drop view hari;
 SHOW CREATE VIEW  hari;
 
 -- Aggregate functions 
 select count(*) from teams;
 select sum(points_scored) from scores;
 select min(points_scored) from scores;
 select max(points_scored) from scores;
 
--  triggers
create table deleted_players(
player_id int,
player_name varchar(100),
deleted_date datetime);


DELIMITER //

CREATE TRIGGER after_player_delete
AFTER DELETE ON Players
FOR EACH ROW 
BEGIN
    INSERT INTO deleted_players (player_id, player_name, deleted_date)
    VALUES (OLD.player_id, OLD.player_name, NOW());
END //

DELIMITER ;

select* from deleted_players;

-- subquery
SELECT p.player_id,p.player_name, s.points_scored FROM Players p JOIN Scores s ON p.player_id = s.player_id WHERE s.points_scored > (SELECT AVG(points_scored) FROM Scores);

-- index
create index  idex_hari on  teams (team_name);
select * from teams t join players p on t.team_id =p.team_id;






  



 
