CREATE TABLE `practical2019`.`sailors` (
  `Sid` INT(20) NOT NULL,
  `Sname` VARCHAR(45) NOT NULL,
  `Rating` INT(10) NULL,
  `AGE` INT(10) NULL,
  PRIMARY KEY (`Sid`));
SELECT * FROM sailors;
INSERT INTO `practical2019`.`sailors` (`Sid`, `Sname`, `Rating`, `AGE`) VALUES ('123', 'Smith', '5', '42');
INSERT INTO `practical2019`.`sailors` (`Sid`, `Sname`, `Rating`, `AGE`) VALUES ('103', 'Harry', '4', '38');
INSERT INTO `practical2019`.`sailors` (`Sid`, `Sname`, `Rating`, `AGE`) VALUES ('117', 'Peter', '2', '71');
INSERT INTO `practical2019`.`sailors` (`Sid`, `Sname`, `Rating`, `AGE`) VALUES ('139', 'Monica', '3', '22');

CREATE TABLE `practical2019`.`Boats` (
`Bid` INT(20) NOT NULL,
`Bname` VARCHAR(45) NOT NULL,
`Color` CHAR(10),
PRIMARY KEY (`Bid`));

INSERT INTO `practical2019`.`Boats` (`Bid`, `Bname`, `Color`) VALUES ('01', 'Diamond', 'Black');
INSERT INTO `practical2019`.`Boats` (`Bid`, `Bname`, `Color`) VALUES ('03', 'Titanic', 'Blue');
INSERT INTO `practical2019`.`Boats` (`Bid`, `Bname`, `Color`) VALUES ('12', 'Century', '5');

CREATE TABLE `practical2019`.`Reserves` (
`Sid` INT(20) NOT NULL,
`Bid` INT(20) NOT NULL,
`Day` INT(10),
PRIMARY KEY (`Bid`,`Sid`));

INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('123', '03', '21');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('103', '12', '8');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('117', '07', '7');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('139', '03', '13');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('117', '12', '14');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('139', '07', '16');
INSERT INTO `practical2019`.`Reserves` (`Sid`, `Bid`, `Day`) VALUES ('123', '07', '18');

SELECT * FROM Reserves;
SELECT sum(Rating) FROM sailors;
-- Find the max age from sailors table

SELECT max(Age) FROM sailors;
-- Find The average age of from Sailors Table:
SELECT avg(Age) FROM sailors;
-- Find out the no of distinct sailors id's from table reserves.
SELECT COUNT(distinct Sid) FROM Reserves;
-- Find the average no of days that each sailors reserves the boat:
SELECT Sid, avg(Day) FROM Reserves GROUP BY Sid;

SELECT distinct Sid, max(Day) FROM Reserves GROUP BY Sid HAVING avg(Day) > 17;

SELECT distinct Sname FROM sailors AS S, Reserves AS R  WHERE S.Sid = R.Sid;
-- Find Colors of Boats Reserved by Harry.
SELECT B.Color FROM Boats B, Reserves R, Sailors S WHERE S.Sname = 'Harry' AND B.Bid = R.Bid AND S.Sid = R.Sid;

 SELECT * FROM practical2019.views;
 


-- create a table to store information about weather observation stations:

CREATE TABLE  `practical2019`.`STATION` (
`ID` INT PRIMARY KEY,
`CITY` CHAR(20),
`STATE` CHAR(2),
`LAT_N` REAL,
`LONG_W` REAL );

-- populate the table station with a few rows:
INSERT INTO `practical2019`.`STATION` (`ID`, `CITY`, `STATE`, `LAT_N`, `LONG_W`) VALUES ('13', 'Phoenix', 'AZ', '33', '112');
INSERT INTO `practical2019`.`STATION` (`ID`, `CITY`, `STATE`, `LAT_N`, `LONG_W`) VALUES ('44', 'Denver', 'CO', '40', '105');
INSERT INTO `practical2019`.`STATION` (`ID`, `CITY`, `STATE`, `LAT_N`, `LONG_W`) VALUES ('66', 'Caribou', 'ME', '47', '68');

-- query to look at table station in undefined order:
SELECT * FROM STATION;

-- query to select Northern station latitude > 39.7:
SELECT * FROM STATION WHERE LAT_N > 39.7;
-- query to select only ID,CITY and STATE columns:
SELECT ID,CITY,STATE FROM STATION;
-- query to both "rstrict" and "project":
SELECT ID,CITY,STATE FROM STATION WHERE LAT_N >39.7;

-- Create another table to store normalized temp and precipation data:
-- ID field must match some STATION table ID
-- rainfall in inches
-- no duplicate ID and Month Combinations.

CREATE TABLE `practical2019`.`STATS` (
`ID` INT NOT NULL,
`MONTH` INT NOT NULL,
`TEMP_F` REAL,
`RAIN_I` REAL,
PRIMARY KEY (`ID`, `MONTH`));

-- insert some statistics for jan and july;
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('13','1','57.4','.31');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('13','7','91.7','5.15');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('44','1','27.3','.18');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('44','7','74.8','.2.11');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('66','1','6.7','2.1');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('66','7','65.8','4.52');
SELECT * FROM STATS;
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('44', '7', '74.8', '2.11');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('66', '1', '6.7', '2.1');
INSERT INTO `practical2019`.`STATS` (`ID`, `MONTH`, `TEMP_F`, `RAIN_I`) VALUES ('66', '7', '65.8', '4.52');

-- query to look at tables STATS, picking up location information joining with table STATION on the ID column:
-- matching two tables on a common coulmn is a called "join".
-- only the column values are required to match.
SELECT * FROM STATION,STATS WHERE STATION.ID = STATS.ID;

-- query to look at temp for january from table STATS, lowest temp first ,picking up city name and latitude by joining table station on th ID column:
SELECT LAT_N,CITY,TEMP_F FROM STATS,STATION WHERE MONTH=1 AND STATS.ID = STATION.ID ORDER BY TEMP_F;

-- query to show MAX and MIN temperatures as well average rainfall for each station:
SELECT MAX(TEMP_F), MIN(TEMP_F), AVG(RAIN_I), ID FROM STATS GROUP BY ID;

-- query to show stations with year round average temp above 50 degree:
SELECT * FROM STATION WHERE 50 < ( SELECT AVG(TEMP_F) FROM STATS WHERE STATION.ID = STATS.ID);

-- cretae a view to convert Fahrenheit to celsius and inches to centimeters:
CREATE VIEW METRIC_STATS (ID,MONTH,TEMP_C,RAIN_C) AS SELECT ID, MONTH,(TEMP_F - 32) * 5/9, RAIN_I * 0.3937 FROM STATS;
SELECT * FROM METRIC_STATS;
-- update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low:
UPDATE STATS SET RAIN_I = RAIN_I + 0.01;
-- take a look
SELECT * FROM STATS;
COMMIT WORK;
-- update two rows , Denvers rainfall readings:
UPDATE STATS SET RAIN_I = 4.50
WHERE ID = 44;
-- take a look
SELECT * FROM STATS;
-- Oops! We meant to update just the july reading! undo that update:
ROLLBACK WORK;
-- take a look:
SELECT * FROM STATS;
