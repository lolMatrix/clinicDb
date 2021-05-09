use db_artem;
DROP DATABASE IF EXISTS db_artem
GO

CREATE database db_artem;
go
USE db_artem;

create table post (
	id int not null identity (1, 1) primary key, 
	name varchar(45) not null, 
	salary FLOAT,
	administrator tinyint
);

create table museum (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	startTime time not null,
	endTime time not null,
	price float
);

create table employee (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	id_post int REFERENCES post (id) not null
);

create table workingDaySheduie (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	startTime time not null,
	endTime time not null,
	idMuseum int not null references museum (id)
);

create table employee_to_workingDaySheduie(
	id_employee int not null REFERENCES employee (id),
	id_workingDaySheduie int not null REFERENCES workingDaySheduie (id)
);

alter table employee_to_workingDaySheduie
	add constraint employee_to_workingDaySheduie_primary_keys primary key (id_employee, id_workingDaySheduie)
go

create table building (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	idMuseum int not null references museum (id)
);

create table room (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	werehouse tinyint not null,
	area float not null,
	idBuilding int not null references building (id)
);

create table excursion (
	id int not null identity (1, 1) primary key,
	name varchar(45) not null,
	price float not null,
	startTime time not null,
	endTime time not null,
	peopleCount int not null
);

create table room_to_excursion(
	id_room int not null REFERENCES room (id),
	id_excursion int not null REFERENCES excursion (id)
);

alter table room_to_excursion
	add constraint room_to_excursion_primary_keys primary key (id_room, id_excursion)
go

CREATE TABLE exhibition (
	id int NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	price FLOAT NOT NULL,
	startTime TIME NOT NULL,
	endTime TIME NOT NULL
);

CREATE TABLE exebition_to_room (
	id_room int NOT NULL REFERENCES room (id),
	id_exebition INT NOT NULL REFERENCES exhibition (id)
);

ALTER TABLE exebition_to_room
	ADD CONSTRAINT exebition_to_room_primary_key PRIMARY KEY (id_room, id_exebition)
GO

CREATE TABLE characteristicName (
	id int NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	name VARCHAR(45) NOT NULL
);

CREATE TABLE characteristicValue (
	id INT NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	value VARCHAR(45) NOT NULL,
	type VARCHAR(45) NOT NULL,
	idName int NOT NULL REFERENCES characteristicName (id)
);

CREATE TABLE exhibit (
	id int NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	idRoom int NOT NULL REFERENCES room (id)
);

CREATE TABLE exhibit_to_character (
	idExhibit int NOT NULL REFERENCES exhibit (id),
	idCharacteristic int  NOT NULL REFERENCES characteristicValue (id)
);

ALTER TABLE exhibit_to_character
	ADD CONSTRAINT exhibit_to_character_primary_key PRIMARY KEY (idExhibit, idCharacteristic)
GO

INSERT INTO post (administrator, name, salary) VALUES (1, 'yes', 21);
INSERT INTO employee (id_post, name) VALUES (1, 'masha');
INSERT INTO museum (endTime, name, price, startTime) VALUES ('23:59:59', 'yes', 10, '00:00:00');
INSERT INTO workingDaySheduie (endTime, idMuseum, name, startTime) VALUES ('23:59:59', 1, 'yes', '23:59:59');
INSERT INTO building (idMuseum, name) VALUES (1, 'yes');
INSERT INTO room (area, idBuilding, name, werehouse) VALUES (1, 1, 'yes', 1);
INSERT INTO exhibition (endTime, name, price, startTime) VALUES ('23:59:59', 'yes', 1, '23:59:59');
INSERT INTO exebition_to_room (id_exebition, id_room) VALUES (1, 1);
INSERT INTO exhibit (idRoom, name) VALUES (1, 'yes');
INSERT INTO characteristicName (name) VALUES ('yes');
INSERT INTO characteristicValue (idName, [type], [value]) VALUES (1, 'yes', 'yes');
INSERT INTO exhibit_to_character (idCharacteristic, idExhibit) VALUES (1, 1);

