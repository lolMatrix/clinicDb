use Clinic;

--заполнение моками
BULK INSERT dbo.Users
FROM 'D:\Users\drles\clinicDb\MOCK_DATA.csv'
WITH ( fieldterminator = ',', rowterminator = '\n');

BULK INSERT Branches
from 'D:\Users\drles\clinicDb\MOCK_DATA (1).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Positions
from 'D:\Users\drles\clinicDb\MOCK_DATA (2).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Employers
from 'D:\Users\drles\clinicDb\MOCK_DATA (3).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Breeds
from 'D:\Users\drles\clinicDb\MOCK_DATA (4).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Animal
from 'D:\Users\drles\clinicDb\MOCK_DATA.csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT States
from 'D:\Users\drles\clinicDb\MOCK_DATA (5).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Receptions
from 'D:\Users\drles\clinicDb\MOCK_DATA (6).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Diseases
from 'D:\Users\drles\clinicDb\MOCK_DATA (7).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Disease_To_Reception
from 'D:\Users\drles\clinicDb\MOCK_DATA (8).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Treatment
from 'D:\Users\drles\clinicDb\MOCK_DATA (9).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Medicians
from 'D:\Users\drles\clinicDb\MOCK_DATA (10).csv'
WITH (fieldterminator = ',', rowterminator = '\n');

BULK INSERT Treatment_to_Medician
from 'D:\Users\drles\clinicDb\MOCK_DATA (11).csv'
WITH (fieldterminator = ',', rowterminator = '\n');
go

--добавление индексов
--Время до добавления 0.613 секунд
--время после 0.217 секунд
--скорость обращания увеличилась ~ в 3 раза

CREATE UNIQUE NONCLUSTERED  INDEX Animal_Hashed ON Animal
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX User_Hashed ON Users
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Branch_Hashed ON Branches
  (
          Id ASC
  )
  GO

  CREATE UNIQUE NONCLUSTERED  INDEX Breeds_Hashed ON Breeds
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Disease_Hashed ON Diseases
  (
          Id ASC
  )
  GO

  CREATE UNIQUE NONCLUSTERED  INDEX Employer_Hashed ON Employers
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Medicians_Hashed ON Medicians
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Position_Hashed ON Positions
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Receptions_Hashed ON Receptions
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX States_Hashed ON States
  (
          Id ASC
  )
  GO
  CREATE UNIQUE NONCLUSTERED  INDEX Treatment_Hashed ON Treatment
  (
          Id ASC
  )
  GO


--Функции и процедуры
--получить всех пользователей
CREATE PROCEDURE allUsers as
    BEGIN
        SELECT * FROM Users
    END;
    go
--Статистика по заболеваемости
CREATE PROCEDURE statisticOfDiseases 
    @firstDate date,
    @secondDate date
    as
    BEGIN
        SELECT Diseases.Name, COUNT(Diseases.Id) as [count]
        FROM Diseases 
        INNER JOIN Disease_To_Reception ON Disease_To_Reception.Disease_Id = Diseases.Id
        INNER JOIN Receptions ON Disease_To_Reception.Reception_Id = Receptions.Id
        WHERE Receptions.Date_Reception BETWEEN @firstDate and @secondDate
        GROUP BY Diseases.Name;
    END;
go
--процент от продаж за определенный переод
CREATE PROCEDURE percentEmployers
    @date date
    as
    BEGIN
        SELECT Employers.Name, Positions.Name as [Position], sum(Medicians.Price) over(Partition By Employers.Id) * 0.1 as [Percent]    
        FROM Employers 
        INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
        INNER JOIN Disease_To_Reception ON Disease_To_Reception.Reception_Id = Receptions.Id
        INNER JOIN Treatment ON Treatment.Disease_Id = Disease_To_Reception.Disease_Id
        INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
        INNER JOIN Medicians ON Treatment_to_Medician.Medician_Id = Medicians.Id
        Inner Join Positions ON Positions.Id = Employers.Id
        WHERE Receptions.Date_Reception > @date
        ORDER BY Employers.Name DESC;
    END;
go
--Был или не был повторный прием
CREATE FUNCTION reReceptions(@reception int)
        RETURNS VARCHAR(50)
        AS
        BEGIN
                DECLARE @name VARCHAR(50);
                
                if @reception IS NULL 
                        BEGIN
                                SET @name = 'Не было';
                        END;
                if @reception IS NOT NULL 
                        BEGIN
                                SET @name = 'Был';
                        END;
                RETURN @name;
        END
        GO
SELECT dbo.reReceptions(Reception_Id) FROM Receptions;
GO
-- Какая цена на лекарство
CREATE FUNCTION price(@price FLOAT)
        RETURNS VARCHAR(50)
        AS
        BEGIN
                DECLARE @name VARCHAR(50);
                SET @name =
                CASE
                        WHEN @price < 10
                                THEN 'Дешево'
                        
                        WHEN @price >= 10 and @price < 50
                                THEN 'Средняя цена'
                WHEN @price >= 50
                        THEN 'Выгодно'
                END;
                RETURN @name;
        END
        GO

SELECT dbo.price(Price) From Medicians;
GO
--Проверяет, можно ли вылечить или пациент безнадежен
CREATE FUNCTION checkDisease(@id_disiase int)
        RETURNS VARCHAR(50)
        AS
        BEGIN
                DECLARE @name VARCHAR(50);
                DECLARE @countDisease int;
                select @countDisease = count(Diseases.Id) FROM Treatment join Diseases on Diseases.Id = Treatment.Disease_Id;
                if @countDisease > 0
                        BEGIN
                                SET @name = 'Можно вылечить';
                        END;
                if @countDisease = 0
                        BEGIN
                                SET @name = 'Безнадежно болен';
                        END;
                RETURN @name;
        END
        GO

SELECT dbo.checkDisease(Id) From Diseases;
GO
--вьюшки 

--Представления животных с названиями пород
CREATE VIEW Animals AS
    SELECT Animal.Id as id, Animal.Name as name, Breeds.Name as breed FROM Animal
        JOIN Breeds ON Breeds.Id = Animal.Breed_Id;
go

-- Карточки болезней животных
CREATE VIEW Cards AS
    SELECT Animal.Id as Id, Animal.Name as Name, Users.Name AS UserName, Receptions.[Description] as Description FROM Animal 
        JOIN Users on Users.Id = Animal.User_Id
        JOIN Receptions on Receptions.Animal_Id = Animal.Id
        where Animal.Id = 5;
GO

-- Рецепты с лекарствами
CREATE VIEW TreatmentMedicians AS
    SELECT Treatment.[Description] AS Treatment, Medicians.Name AS MedicianName, Medicians.Price as Price 
        FROM Treatment_to_Medician
        JOIN Treatment on Treatment.Id = Treatment_to_Medician.Treatment_id
        JOIN Medicians on Medicians.Id = Treatment_to_Medician.Medician_Id;
go

--case when в 2 функцию - сделано
--индекс на контент часто используемый
CREATE NONCLUSTERED INDEX MedicianName ON Medicians
  (
          Name ASC
  )