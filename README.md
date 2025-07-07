🏆 SPORTS MANAGEMENT SYSTEM — README 📘


---

🧾 Overview

Welcome to the Sports Management System project — a full-featured, SQL-powered database solution for managing sports leagues, teams, players, matches, scores, and more. 🏟

This system is designed for ease of use, performance tracking, and data integrity using:

🔗 Relational integrity

🔍 Query efficiency

⚙ Modular architecture

🔐 Transaction safety

📊 Statistical analysis



---

📚 Table of Contents

1. 📂 Schema Overview


2. 🧱 Tables Structure


3. ✍ DML Commands


4. 🧱 DDL Commands


5. 🔎 Queries (DQL)


6. 🧠 Advanced SQL Logic

🔄 Joins

👁 Views

🧰 Stored Procedures

🧵 String Functions

📊 Aggregates

⚠ Triggers

🔁 Subqueries

🧭 Indexing



7. 🛑 Transaction Control


8. 💼 Real-World Use Cases


9. 🧪 Future Enhancements


10. ✅ Conclusion




---

📂 Schema Overview

CREATE SCHEMA sportsproject;
USE sportsproject;
START TRANSACTION;

🗂 A new schema sportsproject is created to isolate your tables and logic into a modular, manageable structure.


---

🧱 Tables Structure

1️⃣ Leagues 🏆

CREATE TABLE Leagues (
    league_id INT PRIMARY KEY,
    league_name VARCHAR(100) NOT NULL,
    level TEXT
);

Example entries: 'Premier League', 'Championship'

Modified column level to TEXT for flexibility

🔐 Added a UNIQUE constraint on league_name



---

2️⃣ Teams 🛡

CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    coach_name VARCHAR(100),
    league_id INT,
    FOREIGN KEY (league_id) REFERENCES Leagues(league_id)
);

5 teams across 2 leagues: Chennai Hawks, Delhi Dynamos, etc.

Coaches assigned for each



---

3️⃣ Players ⚽

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

Roles include Striker, Midfielder, Defender, Goalkeeper, etc.

👥 25 players are registered across teams



---

4️⃣ Matches 🏁

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

Match fixtures include participating teams and winners

🗓 Stored with match dates



---

5️⃣ Scores 🧮

CREATE TABLE Scores (
    score_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    points_scored INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

Tracks individual player performance per match

🥇 Multiple players per match can be scored



---

✍ DML Commands

✅ INSERT, ❌ DELETE, 🔄 UPDATE

INSERT INTO Teams VALUES (106, 'Goa Hulks', 'P. Hari', 2);
DELETE FROM Teams WHERE team_id = 106;
UPDATE Teams SET coach_name = 'P. Hari' WHERE coach_name = 'K. Suresh';

📌 Used to control data changes.


---

🧱 DDL Commands

⚙ Create, alter, drop, and truncate tables.

ALTER TABLE Players ADD COLUMN age INT CHECK(age > 18);
DROP TABLE Matches;
TRUNCATE TABLE Matches;

🛠 Used for modifying schema structure.


---

🔎 Queries (DQL)

📊 Fetching information:

🧑‍🤝‍🧑 All players → SELECT * FROM players;

🎯 Filter top scorers → WHERE points_scored > 2

🧾 League-wise team count → GROUP BY, HAVING

🔤 Sort player names → ORDER BY player_name DESC


SELECT l.league_name, COUNT(t.league_id) AS teams
FROM Leagues l
JOIN Teams t ON l.league_id = t.league_id
GROUP BY l.league_name;


---

🧠 Advanced SQL Logic

🔄 Joins

INNER JOIN → Matches matching data in both tables

LEFT JOIN / RIGHT JOIN → Show unmatched records

CROSS JOIN → Cartesian product

UNION → Simulates full outer join


SELECT * FROM teams t INNER JOIN players p ON t.team_id = p.team_id;


---

👁 Views

Reusable virtual tables:

CREATE VIEW hari AS
SELECT l.league_name, COUNT(t.league_id) AS teams
FROM leagues l LEFT JOIN teams t ON l.league_id = t.league_id
GROUP BY l.league_name;

🗑 You can drop views or recreate them dynamically.


---

🧰 Stored Procedures

DELIMITER //
CREATE PROCEDURE gethari()
BEGIN
    SELECT * FROM players p JOIN scores s ON p.player_id = s.player_id
    WHERE s.player_id = 201;
END //
DELIMITER ;

⚙ Run stored logic for reporting player 201.


---

🧵 String Functions

UPPER(), LOWER(), LENGTH()

LEFT(), RIGHT(), SUBSTRING()

TRIM(), CONCAT(), REVERSE(), LOCATE()


📦 Useful in formatting output, filtering.


---

📊 Aggregate Functions

SELECT COUNT(*) FROM Teams;
SELECT SUM(points_scored) FROM Scores;
SELECT MIN(points_scored) FROM Scores;
SELECT MAX(points_scored) FROM Scores;

🧠 Used in statistical summaries and analytics.


---

⚠ Triggers

Auto-log deleted player info:

CREATE TRIGGER after_player_delete
AFTER DELETE ON Players
FOR EACH ROW
BEGIN
    INSERT INTO deleted_players (player_id, player_name, deleted_date)
    VALUES (OLD.player_id, OLD.player_name, NOW());
END;

📁 Backup table: deleted_players


---

🔁 Subqueries

Compare each player's performance to average:

SELECT p.player_id, p.player_name, s.points_scored
FROM Players p JOIN Scores s ON p.player_id = s.player_id
WHERE s.points_scored > (SELECT AVG(points_scored) FROM Scores);


---

🧭 Indexing

Boost search performance:

CREATE INDEX idex_hari ON Teams (team_name);

🔍 Faster search on team_name.


---

🛑 Transaction Control

SAVEPOINT, ROLLBACK, and COMMIT used for safe data operations

🔐 Protects against unintended data changes


SAVEPOINT sp1;
ROLLBACK TO sp1;
COMMIT;


---

💼 Real-World Use Cases

✅ Track winning teams
✅ Top scoring players
✅ Match summary by date
✅ League strength via teams
✅ Coach-wise performance mapping
✅ View historical changes (via Triggers)


---

🧪 Future Enhancements

🚀 To take it to the next level:

🌐 Add front-end (React, Vue, PHP)

🔐 User authentication (Admins, Coaches)

📈 Visual analytics using charts

📅 Match scheduling automation

📨 Email match reports

🌍 REST API integration



---

✅ Conclusion

This project demonstrates:

📊 Full DBMS design from scratch

🔗 Complete relational integrity

🧠 Real-world sports data simulation

⚙ Usage of all major SQL features: joins, triggers, procedures, views, etc.


📁 You now have a solid SQL-based backend for a complete Sports Management System!
