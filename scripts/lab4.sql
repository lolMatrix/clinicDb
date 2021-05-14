USE Clinic;
-- 15 из функциональных требований
-- изменение лекарства
UPDATE Medicians SET Price = 20 WHERE Price <= 3;
-- Добавление заказа
INSERT INTO Treatment_to_Medician (Treatment_id, Medician_id, Count) VALUES (1, 1, 10);
-- изменение болезни 
UPDATE Diseases SET Name = 'имя болезни' WHERE Name = 'Да';
-- Добавить болезнь
INSERT INTO Diseases (Name, Description) VALUES ('имя болезни', 'описание');
-- отчет по продажам 
SELECT SUM(Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id;

SELECT Medicians.Price, Medicians.Id, Medicians.Name, Receptions.Date_Reception FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception >= '20200101';
-- Вычисление итоговой стоимости заказа
SELECT SUM(Price) FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_id
    WHERE Treatment_to_Medician.Treatment_id = 2;

-- Показ состояния приема
SELECT * FROM Receptions
    INNER JOIN States ON States.Id = Receptions.id_state
    WHERE Receptions.Date_Reception <= '20011213';
--Показ лекарственных средств
SELECT * FROM Medicians;
--Подробная информация о болезни
SELECT * FROM Diseases
    INNER JOIN Treatment ON Treatment.Disease_Id = Diseases.Id
    WHERE Name = 'Орви';
--Запись на прием
INSERT INTO Receptions (Receptions.Emploer_Id, Receptions.Animal_Id, Receptions.Date_Reception, Receptions.[Description])
     VALUES (1, 1, '20210511', 'Все хорошо');

--Отмена приема
DELETE FROM Receptions
    WHERE Date_Reception = '20210511';

--Вычисление итоговой стоимости
SELECT Sum(Medicians.Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception <= '20200101';

--Процент от продаж сотрудникам
SELECT Employers.Name, Positions.Name as [Position], sum(Medicians.Price) over(Partition By Employers.Id) * 0.1 as [Percent]    
    FROM Employers 
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Reception_Id = Receptions.Id
    INNER JOIN Treatment ON Treatment.Disease_Id = Disease_To_Reception.Disease_Id
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Treatment_to_Medician.Medician_Id = Medicians.Id
    Inner Join Positions ON Positions.Id = Employers.Id;

--Статистика по заболеваниям 
SELECT Diseases.Name, COUNT(Diseases.Id) as [count]
    FROM Diseases 
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Disease_Id = Diseases.Id
    INNER JOIN Receptions ON Disease_To_Reception.Reception_Id = Receptions.Id
    WHERE Receptions.Date_Reception BETWEEN '20010101' and '20051231'
    GROUP BY Diseases.Name;
--UPDATE в разных таблицах, с WHERE, можно условно, например, изменить заранее созданные некорректные данные (5 шт.)
UPDATE Animal 
    SET Name = 'Добрый чел, позитивный'
    WHERE Name = 'Джек'
UPDATE Branches 
    SET Name = 'Нижний тагил'
    WHERE Name = 'Спартановка'
UPDATE Medicians 
    SET Name = 'Да'
    WHERE Price = '20'
UPDATE Positions 
    SET Name = 'Врач'
    WHERE Name = 'Чумной доктор'
UPDATE States 
    SET Name = 'Что'
    WHERE Name = 'Удовлетворительное'
      
--DELETE в разных таблицах, с WHERE, можно условно, например, удалить заранее созданные некорректные данные (5 шт.)
DELETE FROM Receptions
    WHERE Date_Reception = '20210511';
DELETE FROM Treatment
    WHERE [Description] = 'Кашель';
DELETE FROM Users
    WHERE Birthday >= '20011213';
DELETE FROM Diseases
    WHERE Name = 'Да';
DELETE FROM Positions
    WHERE Name = 'Чумной доктор';

---GROUP_CONCAT и другие разнообразные функции SQL (2-3 шт.)
SELECT string_agg(Name, ',') as [name] FROM Employers;
SELECT top(3) [Name] FROM Employers;
SELECT COUNT(Name) as [count],  [Name] FROM Employers
    GROUP BY Name;

---SELECT, DISTINCT, WHERE, AND/OR/NOT, IN, BETWEEN, различная работа с датами и числами, преобразование данных, IS NULL, AS для таблиц и столбцов и др. в различных вариациях (20 шт. +)
SELECT DISTINCT Name from Employers;

SELECT count(Distinct Name) as [count of uneqiuls states] FROM States;    

Select Description FROM Receptions
    WHERE Reception_Id IS NULL;

SELECT * FROM Receptions 
    INNER JOIN States ON id_state = States.Id
    WHERE States.Name IN ('Плохое', 'Удовлетворительное')

SELECT * FROM Receptions 
    INNER JOIN States ON id_state = States.Id
    WHERE Date_Reception BETWEEN '20010101' AND '20011231';

SELECT * from Medicians
    WHERE Shelf_life > 10 or Shelf_life < 5;

SELECT * from Medicians
    WHERE Shelf_life > 10 and Shelf_life < 30;

SELECT DISTINCT Name, COUNT(Name) AS [Count repeats] FROM Employers
    GROUP BY Name;

SELECT * FROM Branches
    WHERE Name IN ('Спартановка', 'Ворошиловский', 'Городище');

SELECT * FROM Receptions 
    WHERE Date_Reception > '20180101'

SELECT * FROM Receptions 
    WHERE Reception_Id is not null;

SELECT Name as [nAmE], COUNT(Name) as [count nAmE] FROM Employers
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    GROUP BY Name
    Order by [count nAmE] Desc;

SELECT Name as [nAmE], COUNT(Name) as [count nAmE] FROM Employers
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    GROUP BY Name
    HAVING count(Name) >= 2
    Order by [count nAmE] Desc;

SELECT * FROM Medicians
    WHERE Shelf_life BETWEEN 20 and 100;

SELECT * FROM Diseases 
    WHERE Name IN ('Процессор', 'Миша');

SELECT Breeds.Name AS [Breed], COUNT(Breeds.Name) AS [Count Breeds] FROM Breeds
    INNER JOIN Animal ON Breeds.Id = Animal.Breed_Id
    GROUP BY Breeds.Name
    HAVING COUNT(Breeds.Name) >= 2;

SELECT * FROM Medicians
    WHERE Name IN ('Спутник г', 'Глицин');

---LIKE и другая работа со строками (5-7 шт.+)
SELECT * FROM Receptions
    WHERE [Description] LIKE '% % % %';

SELECT * FROM Employers
    WHERE Name LIKE 'А%';

SELECT UPPER(Name) as [bugurt name] FROM Employers;

SELECT LOWER(Name) AS [puk puk name] FROM Users;

SELECT Name, LEN(Name) as [lenght of name] FROM Animal
    GROUP BY Name;

---SELECT INTO или INSERT SELECT, что поддерживается СУБД (2-3 шт.). Для использования запроса INSERT SELECT вначале можно создать новую тестовую таблицу или несколько, в которые будут скопированы данные из существующих таблиц с помощью данного запроса. Код создания таблиц также приложить в лабораторную работу
SELECT Animal.Name as [Animal Name], Breeds.Name 
    Into Animals_With_Breads
    FROM Animal
    INNER JOIN Breeds ON Breeds.Id = Animal.Breed_Id;

Select Medicians.Name, Medicians.Price, Treatment.[Description]
    INTO Full_Medecians_Description
    FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_Id
    INNER JOIN Treatment ON Treatment_to_Medician.Treatment_id = Treatment_to_Medician.Treatment_id;