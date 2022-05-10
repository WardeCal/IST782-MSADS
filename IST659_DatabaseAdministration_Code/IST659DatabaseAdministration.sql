--Create Database
IF OBJECT_ID('dbo.AllStarList') IS NOT NULL
	DROP VIEW dbo.AllStarList

IF OBJECT_ID('dbo.AvgYearsinLeague') IS NOT NULL
	DROP VIEW dbo.AvgYearsinLeague

IF OBJECT_ID('dbo.CollegeAndNBATeam') IS NOT NULL
	DROP VIEW dbo.CollegeAndNBATeam

IF OBJECT_ID('dbo.CollegesAndAllStarCenters') IS NOT NULL
	DROP VIEW dbo.CollegesAndAllStarCenters

IF OBJECT_ID('dbo.CollegesAndAllStarPointGuards') IS NOT NULL
	DROP VIEW dbo.CollegesAndAllStarPointGuards

IF OBJECT_ID('dbo.CollegesAndAllStarPowerForwards') IS NOT NULL
	DROP VIEW dbo.CollegesAndAllStarPowerForwards

IF OBJECT_ID('dbo.CollegesAndAllStarShootingGuards') IS NOT NULL
	DROP VIEW dbo.CollegesAndAllStarShootingGuards

IF OBJECT_ID('dbo.CollegesAndAllStarSmallForwards') IS NOT NULL
	DROP VIEW dbo.CollegesAndAllStarSmallForwards

IF OBJECT_ID('dbo.CollegesAndNumOfAllStars') IS NOT NULL
	DROP VIEW dbo.CollegesAndNumOfAllStars

--Drop Tables
DROP TABLE

IF EXISTS AllStar_Appearance
	DROP TABLE

IF EXISTS Player
	DROP TABLE

IF EXISTS College
	DROP TABLE

IF EXISTS Position
	DROP TABLE

IF EXISTS AllStarGame
	DROP TABLE

IF EXISTS NBA_Team
	--Create Tables
	CREATE TABLE NBA_Team (
		--Creating Column
		NBATEAMID INT identity PRIMARY KEY
		,TeamName VARCHAR(50) NOT NULL
		,
		)

CREATE TABLE AllStarGame (
	--Creating Column
	AllStarGameID INT identity PRIMARY KEY
	,AllStarGameName VARCHAR(50) DEFAULT 'All Star Game'
	,LocationCity VARCHAR(50) NOT NULL
	,LocationState VARCHAR(50) NOT NULL
	,LocationCountry VARCHAR(50) NOT NULL
	,
	)

CREATE TABLE Position (
	--Creating Column
	PositionID INT identity PRIMARY KEY
	,PositionName VARCHAR(50) NOT NULL
	,PositionDescription VARCHAR(500)
	)

CREATE TABLE College (
	--Creating Column
	CollegeID INT identity PRIMARY KEY
	,CollegeName VARCHAR(50) NOT NULL
	,
	)

CREATE TABLE Player (
	--Creating Column
	PlayerID INT identity PRIMARY KEY
	,FirstName VARCHAR(50) NOT NULL
	,LastName VARCHAR(50) NOT NULL
	,PositionID INT NOT NULL
	,CollegeID INT NOT NULL
	,YearDrafted INT NOT NULL
	,
	--Creating Constraints
	CONSTRAINT FK1_Player FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
	,CONSTRAINT FK2_Player FOREIGN KEY (CollegeID) REFERENCES College(CollegeID)
	)

CREATE TABLE AllStar_Appearance (
	--Creating Column
	AllStar_ApperanceID INT identity PRIMARY KEY
	,NBATeamID INT NOT NULL
	,AllStarGameID INT NOT NULL
	,PlayerID INT NOT NULL
	,YearsPlayersinLeague INT NOT NULL
	,
	--Creating Constraints
	CONSTRAINT FK1_AllStar_Appearance FOREIGN KEY (NBATeamID) REFERENCES NBA_Team(NBATeamID)
	,CONSTRAINT FK2_AllStar_Appearance FOREIGN KEY (AllStarGameID) REFERENCES AllStarGame(AllStarGameID)
	,CONSTRAINT Fk3__AllStar_Appearance FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
	)

--Insert values into Position Table
INSERT INTO Position (
	PositionName
	,PositionDescription
	)
VALUES (
	'Point Guard'
	,'Main ball handler, facilitates teams offense. Usually shorter.'
	)
	,(
	'Shooting Guard'
	,'Great ability to score, shoot, and create offense. Usually shorter.'
	)
	,(
	'Small Forward'
	,'Can shoot or play down low. Guards both big and smaller players. Usually in the middle in terms of height'
	)
	,(
	'Power Forward'
	,'Plays closer to the basket but can shoot midrange shots, helps center with rebounding. Mid to tall in terms of height depending on strenght'
	)
	,(
	'Center'
	,'Plays near the basket. Rebounds, blocks shots made at the basket, and scores with layups and dunks. Usually the tallest one on the court'
	)

--Checking values added 
SELECT *
FROM Position
	--Inserting Values into NBA_Teams
GO

--Insert Data
INSERT INTO NBA_Team (TeamName)
VALUES ('Atlanta Hawks')
	,('Boston Celtics')
	,('Brooklyn Nets')
	,('Charlotte Hornets')
	,('Chicago Bulls')
	,('Cleveland Cavaliers')
	,('Dallas Mavericks')
	,('Denver Nuggets')
	,('Detroit Pistons')
	,('Golden State Warriors')
	,('Houston Rockets')
	,('Indiana Pacers')
	,('Los Angeles Clippers')
	,('Los Angeles Lakers')
	,('Memphis Grizzlies')
	,('Miami heat')
	,('Milwaukee Bucks')
	,('Minnesota Timberwolves')
	,('New Orleans Pelicans')
	,('New York Knicks')
	,('Oklahoma City Thunder')
	,('Orlando Magic')
	,('Philadelphia 76ers')
	,('Phoenix Suns')
	,('Portland Trail Blazers')
	,('Sacramento Kings')
	,('San Antonio Spurs')
	,('Toronto Raptors')
	,('Utah Jazz')
	,('Washington Wizards')

--Checking values added
SELECT *
FROM NBA_Team
	--Altered the table to add coloumn YearGameWasPlayed to help with analysis
GO

ALTER TABLE ALLSTARGAME ADD YearGameWasPlayed INT NOT NULL

--Inserting Values into AllStarGame
INSERT INTO AllStarGame (
	YearGameWasPlayed
	,LocationCity
	,LocationState
	,LocationCountry
	)
VALUES (
	2020
	,'Chicago'
	,'Illinois'
	,'USA'
	)
	,(
	2019
	,'Charlotte'
	,'North Carolina'
	,'USA'
	)
	,(
	2018
	,'Los Angeles'
	,'California'
	,'USA'
	)
	,(
	2017
	,'New Orleans'
	,'Louisiana'
	,'USA'
	)
	,(
	2016
	,'Toronto'
	,'Ontario'
	,'Canada'
	)
	,(
	2015
	,'New York City'
	,'New York'
	,'USA'
	)
	,(
	2014
	,'New Orleans'
	,'Louisiana'
	,'USA'
	)
	,(
	2013
	,'Houston'
	,'Texas'
	,'USA'
	)
	,(
	2012
	,'Orlando'
	,'Florida'
	,'USA'
	)
	,(
	2011
	,'Los Angeles'
	,'California'
	,'USA'
	)
	,(
	2010
	,'Dallas'
	,'Texas'
	,'USA'
	)

--Checking values added
SELECT *
FROM AllStarGame
GO

--Inserting colleges from 2020 All star roster
INSERT INTO College (CollegeName)
VALUES ('University of Kentucky')
	,('Arizona State University')
	,('San Diego State University')
	,('Real Madrid')
	,('St Vincent-St Mary High School')
	,('Wake Forest University')
	,('Weber State')
	,('Mega Basket')
	,('Louisiana State University')
	,('Gonzaga Univeristy')
	,('Duke Univeristy')
	,('University of California, Los Angeles')
	,('Filathlitikos')
	,('University of Kansas')
	,('New Mexico State University')
	,('University of Connecticut')
	,('University of Oklahoma')
	,('Univeristy of Louisville')
	,('Marquette University')
	,('Cholet Basket')
	,('Villanova University')
	,('Texas A&M University')

--Checking values added
SELECT *
FROM College

-- Fixing Spelling Error
UPDATE College
SET CollegeName = 'Weber State University'
WHERE CollegeName = 'Weber State'
GO

--Test run at adding values into players with foreign keys 
INSERT INTO Player (
	FirstName
	,LastName
	,PositionID
	,CollegeID
	,YearDrafted
	)
VALUES (
	'Anthony'
	,'Davis'
	,4
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Kentucky'
		)
	,2012
	)

SELECT *
FROM Player
GO

--Inserting values into table Player
INSERT INTO Player (
	FirstName
	,LastName
	,PositionID
	,CollegeID
	,YearDrafted
	)
VALUES (
	'James'
	,'Harden'
	,2
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Arizona State University'
		)
	,2009
	)
	,(
	'Kawhi'
	,'Leonard'
	,3
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'San Diego State University'
		)
	,2011
	)

--Inserting values into table Player
INSERT INTO Player (
	FirstName
	,LastName
	,PositionID
	,CollegeID
	,YearDrafted
	)
VALUES (
	'Luka'
	,'Doncic'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Real Madrid'
		)
	,2018
	)
	,(
	'Lebron'
	,'James'
	,3
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'St Vincent-St Mary High School'
		)
	,2003
	)
	,(
	'Chris'
	,'Paul'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Wake Forest University'
		)
	,2005
	)
	,(
	'Devin'
	,'Booker'
	,2
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Kentucky'
		)
	,2015
	)
	,(
	'Nikola'
	,'Jokic'
	,5
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Mega Basket'
		)
	,2012
	)
	,(
	'Ben'
	,'Simmons'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Louisiana State University'
		)
	,2016
	)
	,(
	'Domantas'
	,'Sabonis'
	,4
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Gonzaga Univeristy'
		)
	,2016
	)
	,(
	'Jayson'
	,'Tatum'
	,3
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Duke Univeristy'
		)
	,2017
	)
	,(
	'Russell'
	,'Westbrook'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of California, Los Angeles'
		)
	,2008
	)
	,(
	'Giannis'
	,'Antetokounmpo'
	,4
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Filathlitikos'
		)
	,2013
	)
	,(
	'Joel'
	,'Embiid'
	,5
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Kansas'
		)
	,2014
	)
	,(
	'Pascal'
	,'Siakam'
	,4
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'New Mexico State University'
		)
	,2016
	)
	,(
	'Kemba'
	,'Walker'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Connecticut'
		)
	,2011
	)
	,(
	'Trae'
	,'Young'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Oklahoma'
		)
	,2018
	)
	,(
	'Bam'
	,'Adebayo'
	,5
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'University of Kentucky'
		)
	,2017
	)
	,(
	'Brandon'
	,'Ingram'
	,4
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Duke Univeristy'
		)
	,2016
	)
	,(
	'Donovan'
	,'Mithcell'
	,2
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Univeristy of Louisville'
		)
	,2017
	)
	,(
	'Jimmy'
	,'Butler'
	,3
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Marquette University'
		)
	,2011
	)
	,(
	'Rudy'
	,'Gobert'
	,5
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Cholet Basket'
		)
	,2013
	)
	,(
	'Kyle'
	,'Lowry'
	,1
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Villanova University'
		)
	,2006
	)
	,(
	'Khris'
	,'Middleton'
	,3
	,(
		SELECT College.CollegeID
		FROM College
		WHERE CollegeName = 'Texas A&M University'
		)
	,2012
	)

--Check info added
SELECT *
FROM Player

UPDATE Player
SET LastName = 'Mitchell'
WHERE LastName = 'Mithcell'
GO

--Drop this column. Would be easier to calculate in a Select Statement
ALTER TABLE AllStar_Appearance

DROP COLUMN YearsPlayersinLeague

--Test Run adding info
INSERT INTO AllStar_Appearance (
	PlayerID
	,AllStarGameID
	,NBATeamID
	)
VALUES (
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Davis'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Los Angeles Lakers'
		)
	)

SELECT *
FROM AllStar_Appearance

-- Fixing Spelling Error
--Inserting the rest of my info
INSERT INTO AllStar_Appearance (
	PlayerID
	,AllStarGameID
	,NBATeamID
	)
VALUES (
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Harden'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Houston Rockets'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Leonard'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Los Angeles Clippers'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Doncic'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Dallas Mavericks'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'James'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Los Angeles Lakers'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Paul'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Oklahoma City Thunder'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Booker'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Phoenix Suns'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Jokic'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Denver Nuggets'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Simmons'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Philadelphia 76ers'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Sabonis'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Indiana Pacers'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Tatum'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Boston Celtics'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Westbrook'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Houston Rockets'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Antetokounmpo'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Milwaukee Bucks'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Embiid'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Philadelphia 76ers'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Siakam'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Toronto Raptors'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Walker'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Boston Celtics'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Young'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Atlanta Hawks'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Adebayo'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Miami Heat'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Ingram'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'New Orleans Pelicans'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Mitchell'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Utah Jazz'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Butler'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Miami Heat'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Gobert'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Utah Jazz'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Lowry'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Toronto Raptors'
		)
	)
	,(
	(
		SELECT PlayerID
		FROM Player
		WHERE LastName = 'Middleton'
		)
	,(
		SELECT AllStarGameID
		FROM AllStarGame
		WHERE YearGameWasPlayed = 2020
		)
	,(
		SELECT NBATEAMID
		FROM NBA_Team
		WHERE TeamName = 'Milwaukee Bucks'
		)
	)

--Check to ensure data is corrent
SELECT *
FROM AllStar_Appearance
GO

-- View to see all All Star Appearances
CREATE
	OR

ALTER VIEW AllStarList
AS
SELECT AllStarGame.YearGameWasPlayed AS AllStarGameYear
	,Player.FirstName + ' ' + Player.LastName AS Player_Name
	,NBA_Team.TeamName
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID

SELECT *
FROM AllStarList
GO

/*
	The following 5 views created helps us answer the data question
	"Do some colleges tend to produce All-Stars at certain positions?"
	This allows you to view the colleges that produce the most All Stars at a certian position
*/
--Create View to see the College that produces the most Small Forwards
CREATE
	OR

ALTER VIEW CollegesAndAllStarSmallForwards
AS
SELECT CollegeName
	,COUNT(*) AS NumOfAllStarSmallForwards
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
JOIN Position ON Position.PositionID = Player.PositionID
WHERE Position.PositionName = 'Small Forward'
GROUP BY CollegeName

--Check View
SELECT *
FROM CollegesAndAllStarSmallForwards
ORDER BY NumOfAllStarSmallForwards DESC
GO

--Create View to see the College that produces the most Power Forwards
CREATE
	OR

ALTER VIEW CollegesAndAllStarPowerForwards
AS
SELECT CollegeName
	,COUNT(*) AS NumOfAllStarPowerForwards
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
JOIN Position ON Position.PositionID = Player.PositionID
WHERE Position.PositionName = 'Power Forward'
GROUP BY CollegeName

--Check View
SELECT *
FROM CollegesAndAllStarPowerForwards
ORDER BY NumOfAllStarPowerForwards DESC
GO

--Create View to see the College that produces the most Centers
CREATE
	OR

ALTER VIEW CollegesAndAllStarCenters
AS
SELECT CollegeName
	,COUNT(*) AS NumOfAllStarCenters
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
JOIN Position ON Position.PositionID = Player.PositionID
WHERE Position.PositionName = 'Center'
GROUP BY CollegeName

--Check View
SELECT *
FROM CollegesAndAllStarCenters
ORDER BY NumOfAllStarCenters DESC
GO

--Create View to see the College that produces the most Point Guards
CREATE
	OR

ALTER VIEW CollegesAndAllStarPointGuards
AS
SELECT CollegeName
	,COUNT(*) AS NumOfAllStarPointGuards
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
JOIN Position ON Position.PositionID = Player.PositionID
WHERE Position.PositionName = 'Point Guard'
GROUP BY CollegeName

--Check View
SELECT *
FROM CollegesAndAllStarPointGuards
ORDER BY NumOfAllStarPointGuards DESC
GO

--Create View to see the College that produces the most Shooting Guards
CREATE
	OR

ALTER VIEW CollegesAndAllStarShootingGuards
AS
SELECT CollegeName
	,COUNT(*) AS NumOfAllStarShootingGuards
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
JOIN Position ON Position.PositionID = Player.PositionID
WHERE Position.PositionName = 'Shooting Guard'
GROUP BY CollegeName

--Create View to see the College that produces the most Shooting Guards
SELECT *
FROM CollegesAndAllStarShootingGuards
ORDER BY NumOfAllStarShootingGuards DESC
GO

/*
	The following view created helps us answer the data question
	"What college has the greatest number of All Star appearances? "
	This allows you to view the colleges that has the greatest number of All Star Apperances 
*/
CREATE
	OR

ALTER VIEW CollegesAndNumOfAllStars
AS
SELECT CollegeName
	,COUNT(AllStar_ApperanceID) AS NumOfAllStarAppearances
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
GROUP BY CollegeName

--Checking View and Ordering by Descending number of All Star Appearances
SELECT *
FROM CollegesAndNumOfAllStars
ORDER BY NumOfAllStarAppearances DESC
GO

/*
	The following view created helps us answer the data question
	"What is the average time in the league that a player has at time of All-Star Appearance?"
	This shows the aveage years of All Stars in the league 
*/
CREATE
	OR

ALTER VIEW AvgYearsinLeague
AS
SELECT AVG(AllStarGame.YearGameWasPlayed - Player.YearDrafted) AS AVGYearsInLeague
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID

--Checking View
SELECT *
FROM AvgYearsinLeague
GO

/*
	The following view created helps us answer the data question
	"Is there a combination of NBA team playing for and college played that produces multiple All-Star appearances?"
	It shows Combinations of NBA Teams and College Teams and number of Apperances 
*/
CREATE
	OR

ALTER VIEW CollegeAndNBATeam
AS
SELECT CollegeName
	,TeamName
	,COUNT(AllStar_ApperanceID) AS NumOfAllStarAppearances
FROM AllStar_Appearance
JOIN NBA_Team ON NBA_Team.NBATEAMID = AllStar_Appearance.NBATeamID
JOIN Player ON Player.PlayerID = AllStar_Appearance.PlayerID
JOIN AllStarGame ON AllStarGame.AllStarGameID = AllStar_Appearance.AllStarGameID
JOIN College ON College.CollegeID = Player.CollegeID
GROUP BY CollegeName
	,NBA_Team.TeamName

--Checking View
SELECT *
FROM CollegeAndNBATeam
