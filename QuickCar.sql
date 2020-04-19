
CREATE DATABASE QuickCar
GO
USE QuickCar
GO

CREATE TABLE Cars(
CarID int IDENTITY(1,1) PRIMARY KEY Not Null,
NameCar nchar(50) Not Null,
YearCar int DEFAULT YEAR(GetDate()) Not Null 
		CHECK(YearCar BETWEEN YEAR(GetDate())-10 AND YEAR(GetDate())),
TotalUsedTimes tinyint CHECK(TotalUsedTimes BETWEEN 0 AND 50) DEFAULT 0
--InUse bit DEFAULT 0,
)

CREATE TABLE Clients(
ClientID int IDENTITY(1,1) PRIMARY KEY Not Null,
ClientName nchar(30) Not Null,
ClientSurname nchar(30) Not Null,
)

CREATE TABLE CarInUse(
HireID int PRIMARY KEY Not Null,
ClientID int Not Null,
CarID int Not Null,
StartTime datetime DEFAULT GetDate() CHECK(StartTime>= GetDate()),
StopTime datetime CHECK (StopTime>= GetDate()+1),
CONSTRAINT FK_Client_CarInUse FOREIGN KEY (ClientID) REFERENCES Clients (ClientID) ON DELETE NO ACTION,
CONSTRAINT FK_Car_CarInUse FOREIGN KEY (CarID) REFERENCES Cars (CarID) ON DELETE NO ACTION
)

/* 
CREATE TABLE Drivers(
DriverID int IDENTITY(1,1) PRIMARY KEY Not Null,
DriverName nchar(30) Not Null,
DriverSurname nchar(30) Not Null,
) 
*/

CREATE TABLE RepairStatus(
RepairStatusID int IDENTITY(1,1) UNIQUE,
RepairStatusText nchar(50) UNIQUE Not null,
)

CREATE TABLE CarsInService(
CarsInServiceID int PRIMARY KEY Not null,
CarID int Not Null,
Comments nchar(250),
CarStatus int Not Null,	
--CHECK(CarStatus IN ('InQueue', 'Repairing', 'Repaired')),
StartServTime datetime DEFAULT GetDate() CHECK(StartServTime>= GetDate()),
StopServTime datetime CHECK(StopServTime>= GetDate()+1),
CONSTRAINT FK_CarInService_RepairStatus FOREIGN KEY (CarStatus) REFERENCES RepairStatus (RepairStatusID) ON DELETE NO ACTION,
CONSTRAINT FK_Car_CarInService FOREIGN KEY (CarID) REFERENCES Cars (CarID) ON DELETE NO ACTION
)

CREATE TABLE CarsSold(
CarsSoldID int PRIMARY KEY Not Null,
CarID int UNIQUE Not Null,
--NameCar nchar(50) Not Null,
--YearCar int DEFAULT YEAR(GetDate()) Not Null
		--CHECK(YearCar<YEAR(GetDate())),
SoldTime datetime DEFAULT GetDate()
CONSTRAINT FK_Cars_CarsSold FOREIGN KEY (CarID) REFERENCES Cars (CarID) ON DELETE NO ACTION,
)

INSERT into Cars (NameCar,YearCar) values ('Pontiac GTO','2019'), ('Ford Fiesta','2017'), ('Porsche GT3RS','2018'), ('Opel Corsa F', '2019')

INSERT into Clients (ClientName, ClientSurname) values ('David', 'Beckham'), ('John', 'Cena'), ('Tom', 'Hanks')

INSERT into RepairStatus (RepairStatusText) values ('InQueue'), ('Repairing'), ('Repaired')

--INSERT into Drivers (DriverName, DriverSurname) values ('Marcin', 'Masnowski'), ('Grzegorz', 'Waszczykowski'), ('Robert', 'Góral')