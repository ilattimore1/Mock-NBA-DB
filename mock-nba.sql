DROP TABLE Players CASCADE CONSTRAINTS;
DROP TABLE Coaches CASCADE CONSTRAINTS;
DROP TABLE Teams CASCADE CONSTRAINTS;
DROP TABLE Refs CASCADE CONSTRAINTS;
DROP TABLE Games CASCADE CONSTRAINTS;
DROP TABLE Championships CASCADE CONSTRAINTS;
DROP TABLE Regulates CASCADE CONSTRAINTS;
DROP TABLE History CASCADE CONSTRAINTS;
DROP TABLE FunFacts CASCADE CONSTRAINTS;
DROP TABLE Positions CASCADE CONSTRAINTS;
DROP TABLE PlayerParticipation CASCADE CONSTRAINTS;
DROP TABLE TeamParticipation CASCADE CONSTRAINTS;
DROP TABLE RetiredJerseys CASCADE CONSTRAINTS;
DROP TABLE GameScores CASCADE CONSTRAINTS;

CREATE TABLE Players (
    Bdate    DATE,
    Fname    VARCHAR2(20),
    Lname    VARCHAR2(20),
    Debut       DATE,
    HeightFt  NUMBER(1),
    HeightIn    NUMBER(2),
    HeightM     NUMBER(3,2),
    WeightLb    NUMBER(3),
    WeightKg    NUMBER(3),
    Team    VARCHAR2(10),
    CONSTRAINT Players_Fname_Lname_PK PRIMARY KEY(Fname, Lname)
);

CREATE TABLE Positions (
    Fname   VARCHAR2(20),
    Lname   VARCHAR2(20),
    Position VARCHAR2(20),
    CONSTRAINT Positions_PK PRIMARY KEY(Fname, Lname, Position)
);

CREATE TABLE Coaches(
    Fname    VARCHAR2(20),
    Lname    VARCHAR2(20),
    Position    VARCHAR2(10),
    Team    VARCHAR2(10),
    CONSTRAINT Coaches_Fname_Lname_PK PRIMARY KEY(Fname, Lname)
);

CREATE TABLE Refs(
    Fname    VARCHAR2(20),
    Lname    VARCHAR2(20),
    HSName  VARCHAR2(20),
    HSState CHAR(2),
    College VARCHAR2(30),
    ResideCity  VARCHAR2(20),
    ResideSt    CHAR(2),
    RefNumber   NUMBER(2) CONSTRAINT Refs_RefNumber_PK PRIMARY KEY,
    Bdate   DATE,
    BCity   VARCHAR2(20),
    BState CHAR(2),
    Experience NUMBER(2)
);

CREATE TABLE Games(
    StartDate DATE,
    Start24HR   NUMBER(2),
    StartMin    NUMBER(2),
    City    VARCHAR2(20),
    State  CHAR(2),
    Venue   VARCHAR2(20),
    Winner  VARCHAR2(10),
    CONSTRAINT Games_PK PRIMARY KEY(StartDate, Start24HR, StartMin, City, State, Venue)
);

CREATE TABLE Teams(
    Name VARCHAR2(10) CONSTRAINT Team_Name_PK PRIMARY KEY,
    Win NUMBER(2),
    Loss NUMBER(2),
    Streak CHAR(3),
    PPG NUMBER(3,1),
    OPPG NUMBER(3,1),
    RPG NUMBER(3,1),
    APG NUMBER(3,1)
);

CREATE TABLE Championships(
    Team VARCHAR2(10),
    Season CHAR(4) CONSTRAINT Championships_Season_PK PRIMARY KEY,
    Karat CHAR(2)
);

CREATE TABLE History(
    Team VARCHAR2(10),
    Season CHAR(4),
    Playoff VARCHAR2(10),
    CONSTRAINT History_Team_Season_PK PRIMARY KEY(Team, Season)
);

CREATE TABLE Regulates(
    RefNumber NUMBER(2),
    StartDate DATE,
    Start24HR   NUMBER(2),
    StartMin    NUMBER(2),
    City    VARCHAR2(20),
    State  CHAR(2),
    Venue   VARCHAR2(20),
    CONSTRAINT Regulates_PK PRIMARY KEY(RefNumber, StartDate, Start24HR, StartMin, City, State, Venue)
);

CREATE TABLE FunFacts (
    RefNumber NUMBER(2),
    Fact    VARCHAR2(100),
    CONSTRAINT FunFacts_PK PRIMARY KEY(RefNumber, Fact)
);

CREATE TABLE PlayerParticipation (
    Fname VARCHAR2(20),
    Lname VARCHAR2(20),
    StartDate DATE,
    Start24HR   NUMBER(2),
    StartMin    NUMBER(2),
    City    VARCHAR2(20),
    State  CHAR(2),
    Venue   VARCHAR2(20),
    CONSTRAINT PlayerParticipation_PK PRIMARY KEY(Fname, Lname, StartDate, Start24HR, StartMin, City, State, Venue)
);

CREATE TABLE TeamParticipation (
    Team VARCHAR2(20),
    StartDate DATE,
    Start24HR   NUMBER(2),
    StartMin    NUMBER(2),
    City    VARCHAR2(20),
    State  CHAR(2),
    Venue   VARCHAR2(20),
    CONSTRAINT TeamParticipation_PK PRIMARY KEY(Team, StartDate, Start24HR, StartMin, City, State, Venue)
);

CREATE TABLE RetiredJerseys (
    Team    VARCHAR2(20),
    JerseyNum   CHAR(2),
    CONSTRAINT RetiredJerseys_PK PRIMARY KEY(Team, JerseyNum)
);

CREATE TABLE GameScores (
    StartDate DATE,
    Start24HR   NUMBER(2),
    StartMin    NUMBER(2),
    City    VARCHAR2(20),
    State  CHAR(2),
    Venue   VARCHAR2(20),
    QuarterNumber CHAR(1),
    HomePts NUMBER(2),
    AwayPts NUMBER(2),
    CONSTRAINT GameScores_PK PRIMARY KEY(StartDate, Start24HR, StartMin, City, State, Venue, QuarterNumber)
);

ALTER TABLE Players
ADD CONSTRAINT Players_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE Positions
ADD CONSTRAINT Positions_FK FOREIGN KEY(Fname, Lname)
REFERENCES Players(Fname, Lname);

ALTER TABLE Coaches
ADD CONSTRAINT Coaches_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE Championships
ADD CONSTRAINT Championships_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE History
ADD CONSTRAINT History_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE Regulates
ADD CONSTRAINT Regulates_RefNumber_FK FOREIGN KEY(RefNumber)
REFERENCES Refs(RefNumber);

ALTER TABLE Regulates
ADD CONSTRAINT Regulates_Game_FK FOREIGN KEY(StartDate, Start24HR, StartMin, City, State, Venue)
REFERENCES Games(StartDate, Start24HR, StartMin, City, State, Venue);

ALTER TABLE FunFacts
ADD CONSTRAINT FunFacts_RefNumber_FK FOREIGN KEY(RefNumber)
REFERENCES Refs(RefNumber);

ALTER TABLE PlayerParticipation
ADD CONSTRAINT PlayerParticipation_Player_FK FOREIGN KEY(Fname, Lname)
REFERENCES Players(Fname, Lname);

ALTER TABLE PlayerParticipation
ADD CONSTRAINT PlayerParticipation_Game_FK FOREIGN KEY(StartDate, Start24HR, StartMin, City, State, Venue)
REFERENCES Games(StartDate, Start24HR, StartMin, City, State, Venue);

ALTER TABLE TeamParticipation
ADD CONSTRAINT TeamParticipation_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE TeamParticipation
ADD CONSTRAINT TeamParticipation_Game_FK FOREIGN KEY(StartDate, Start24HR, StartMin, City, State, Venue)
REFERENCES Games(StartDate, Start24HR, StartMin, City, State, Venue);

ALTER TABLE RetiredJerseys
ADD CONSTRAINT RetiredJerseys_Team_FK FOREIGN KEY(Team)
REFERENCES Teams(Name);

ALTER TABLE GameScores
ADD CONSTRAINT GameScores_Game_FK FOREIGN KEY(StartDate, Start24HR, StartMin, City, State, Venue)
REFERENCES Games(StartDate, Start24HR, StartMin, City, State, Venue);

INSERT INTO Teams
VALUES('Lakers',49,14,'L1',99.9,9.99,46.1,25.9);

INSERT INTO Players
VALUES('30-DEC-84','LeBron','James','1-JUNE-03',6,9,2.06,250,113,'Lakers');

INSERT INTO players
VALUES('26-DEC-90','Avery','Bradley','1-JUNE-10',6,3,1.9,180,81,'Lakers');

INSERT INTO players
VALUES('06-JUNE-87','Danny','Green','1-JUNE-09',6,6,1.9,215,98,'Lakers');

INSERT INTO Positions
VALUES('LeBron','James','F');

INSERT INTO Positions
VALUES('Danny','Green','G');

INSERT INTO Positions
VALUES('Avery','Bradley','G');

INSERT INTO teams
VALUES('Hawks',20,47,'L1',91.8,99.7,43.3,24);

INSERT INTO players
VALUES('18-MAY-94','Clint','Capela','1-JUNE-14',6,10,2.08,240,108,'Hawks');

INSERT INTO players
VALUES('28-OCT-93','Treveon','Graham','1-JUNE-16',6,5,1.96,219,99,'Hawks');

INSERT INTO players
VALUES('10-JUNE-88','Jeff','Teague','1-JUNE-88',6,3,1.9,195,89,'Hawks');

INSERT INTO Coaches
VALUES('Lloyd','Pierce','Head','Hawks');

INSERT INTO Coaches
VALUES('Melvin','Hunt','Assistant','Hawks');

INSERT INTO Coaches
VALUES('Chris','Jent','Assistant','Hawks');

INSERT INTO Coaches
VALUES('Frank','Vogel','Head','Lakers');

INSERT INTO Coaches
VALUES('Jason','Kidd','Assistant','Lakers');

INSERT INTO Coaches
VALUES('Phil','Handy','Assistant','Lakers');

INSERT INTO teams
VALUES('Bulls',22,43,'W1',96.8,99.9,41.9,23.2);

INSERT INTO coaches
VALUES('Jim','Boylen','Head','Bulls');

INSERT INTO coaches
VALUES('Roy','Rogers','Assistant','Bulls');